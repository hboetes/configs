;;; tex-skak.el --- Major mode for editing LaTeX files using the skak package

;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: Mario Lang <mlang@delysid.org>
;; Keywords: extensions, games, tex

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This file implements a special mode for editing LaTeX documents
;; which make use of the skak package, a TeX extension for typsetting
;; chess moves and board diagrams.

;; This file makes use of the AUC TeX and chess.el packages of which
;; both are not (yet) part of GNU Emacs.
;; You will need to obtain both packages first to be able to use this file.

;; The main features provided by this mode are:

;; * Display the current position in the TeX file in a Chessboard display:
;;   Simply use C-l (`TeX-skak-show-position') in TeX-skak-mode buffers to
;;   display the position at point using your favourite Chessboard display
;;   style (see `chess-default-display').  Basically, the position
;;   shown is the same which would be rendered if you'd use a \showboard
;;   macro at this location.  I.e., \variation and the-like macros are ignored.
;; * Enter mainline, variation, and single ply moves using a Chessboard
;;   display:
;;   To input a series of moves (or just one ply for a specific color), use
;;   either C-c RET (`Tex-insert-macro') or the special keybindings defined
;;   for tex-skak macros (see `Tex-skak-mode-map').  Your favourite
;;   Chessboard display will pop up, and you can perform the moves as if you
;;   were playing a normal game (either by using the mouse, algebraic
;;   notation on the keyboard or selecting pieces by moving point and
;;   using RET).  If you are inputting a series of moves (i.e., as argument
;;   for the \mainline, \variation or \hidemoves macro, you can finish
;;   input by hitting C-c C-c (see `TeX-skak-input-moves-map').

;;; Code:

(require 'latex)
(require 'chess)

;;; Variables:

(defvar TeX-skak-display nil
  "The display object to use for this buffer.")
(make-variable-buffer-local 'TeX-skak-display)

(defvar TeX-skak-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map LaTeX-mode-map)
    (define-key map (kbd "C-l") 'TeX-skak-show-position)
    (define-key map (kbd "C-c C-i") nil)
    (define-key map (kbd "C-c C-i C-b") 'TeX-skak-insert-bmove)
    (define-key map (kbd "C-c C-i C-h") 'TeX-skak-insert-hidemoves)
    (define-key map (kbd "C-c C-i C-m") 'TeX-skak-insert-mainline)
    (define-key map (kbd "C-c C-i C-n") 'TeX-skak-insert-newgame)
    (define-key map (kbd "C-c C-i C-v") 'TeX-skak-insert-variation)
    (define-key map (kbd "C-c C-i C-w") 'TeX-skak-insert-wmove)
    map)
  "Keymap for TeX-skak-mode.")

(defvar TeX-skak-input-move-map
  (let ((map (copy-keymap chess-display-safe-map)))
    (define-key map [?A] 'chess-display-manual-move)
    (define-key map [?C] 'chess-display-duplicate)
    (define-key map [(control ?r)] 'chess-display-search-backward)
    (define-key map [(control ?s)] 'chess-display-search-forward)
    (dolist (key '(?a ?b ?c ?d ?e ?f ?g ?h
		   ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8
		   ?r ?n ?b ?q ?k
		   ?R ?N ?B ?Q ?K
		   ?o ?O ?x))
      (define-key map (vector key) 'chess-input-shortcut))
    (define-key map [backspace] 'chess-input-shortcut-delete)

    (define-key map [(control ?m)] 'chess-display-select-piece)
    (define-key map [return] 'chess-display-select-piece)
    (cond
     ((featurep 'xemacs)
      (define-key map [(button1)] 'chess-display-mouse-select-piece)
      (define-key map [(button2)] 'chess-display-mouse-select-piece)
      (define-key map [(button3)] 'ignore))
     (t
      (define-key map [down-mouse-1] 'chess-display-mouse-select-piece)
      (define-key map [drag-mouse-1] 'chess-display-mouse-select-piece)

      (define-key map [down-mouse-2] 'chess-display-mouse-select-piece)
      (define-key map [drag-mouse-2] 'chess-display-mouse-select-piece)

      (define-key map [mouse-3] 'ignore)))

    (define-key map [menu-bar files] 'undefined)
    (define-key map [menu-bar edit] 'undefined)
    (define-key map [menu-bar options] 'undefined)
    (define-key map [menu-bar buffer] 'undefined)
    (define-key map [menu-bar tools] 'undefined)
    (define-key map [menu-bar help-menu] 'undefined)

    map)
  "The mode map used in a TeX skak input buffer.")

(defvar TeX-skak-input-moves-map
  (let ((map (copy-keymap TeX-skak-input-move-map)))
    (define-key map [?R] 'chess-display-retract)
    (define-key map [(control ?c) (control ?t)] 'chess-display-undo)
    (define-key map [(control ?c) (control ?c)] 'TeX-skak-finish-input)
    map)
  "The mode map used in a TeX skak input buffer in multiple ply mode.")

(defvar TeX-skak-input-index nil
  "Ply index at which move input started.")
(make-variable-buffer-local 'TeX-skak-input-index)

(defvar TeX-skak-input-marker nil
  "The location at which to finally insert the move text.")
(make-variable-buffer-local 'TeX-skak-input-marker)

;;; Functions:

(defun TeX-skak-display ()
  "Create a chess display for this TeX buffer if non already exists."
  (if (or (not TeX-skak-display)
	  (not (buffer-live-p TeX-skak-display)))
      (setq TeX-skak-display (chess-create-display t))
    TeX-skak-display))

(defun TeX-skak-show-position (&optional point)
  "Show the current position at POINT.
This is achieved by first scanning backward for a \\newgame macro, and then
applying all relevant constructs in the region between the first \\newgame
and POINT to the chess game object associated with `TeX-skak-display'."
  (interactive)
  (save-excursion
    (when point (goto-char point))
    (save-restriction
      (narrow-to-region (progn (skip-chars-forward "^\t\n\r ") (point))
			(re-search-backward "\\\\newgame"))
      (goto-char (point-min))
      (while (re-search-forward
	      "\\\\\\(newgame\\)\\|\\(fenboard{\\(.+\\)}\\)\\|\\(\\(mainline\\|hidemoves\\){\\)" nil t)
	(cond ((match-string 1) ; \newgame
	       (chess-display-set-position (TeX-skak-display)))
	      ((match-string 2) ; \fenboard{...}
	       (chess-display-set-position
		(TeX-skak-display)
		(chess-fen-to-pos
		 (mapconcat 'identity
			    (nbutlast (split-string (match-string 3) " +") 2)
			    " "))))
	      ((match-string 4) ; \mainline or \hidemoves
	       (catch 'done
		 (while (not (eobp))
		   (cond
		    ((looking-at "[1-9][0-9]*\\.[. ]*")
		     (goto-char (match-end 0)))
		    ((looking-at chess-algebraic-regexp)
		     (goto-char (match-end 0))
		     (let* ((move (match-string-no-properties 0))
			    (ply (chess-algebraic-to-ply
				  (chess-display-position (TeX-skak-display))
				  move)))
		       (unless ply
			 (chess-error 'pgn-read-error move))
		       (chess-game-move (chess-display-game (TeX-skak-display))
					ply)))
		    ((looking-at "}")
		     (throw 'done t))
		    (t
		     (message "Unhandled construct, stopping.")
		     (throw 'done t)))
		   (skip-chars-forward "\n\t\r "))))))
      (chess-display-popup TeX-skak-display)
      TeX-skak-display)))

;;;###autoload
(define-derived-mode TeX-skak-mode LaTeX-mode "TeX-skak"
  "Special mode for editing LaTeX files which use the skak package."
  (TeX-add-symbols
   '("newgame")
   '("fenboard" (TeX-arg-string "FEN string"))
   '("mainline" (TeX-arg-eval TeX-skak-input))
   '("hidemoves" (TeX-arg-eval TeX-skak-input))
   '("variation" (TeX-arg-eval TeX-skak-input))
   '("wmove" (TeX-arg-eval TeX-skak-input t))
   '("bmove" (TeX-arg-eval TeX-skak-input t t))))

;;;###autoload
(add-to-list
 'TeX-format-list
 (list "TeX-skak" 'TeX-skak-mode "\\\\usepackage\\(\\[.+\\]\\)?{skak}"))

(defun TeX-skak-input (&optional single-ply for-black)
  "Setup a special Chessboard display for move input.
Optionally, if SINGLE-PLY is non-nil, only wait for one ply.
If FOR-BLACK is non-nil, make sure that it is Black's turn to move."
  (let ((place (point-marker)))
    (with-current-buffer (TeX-skak-show-position)
      (if (not single-ply)
	  (use-local-map TeX-skak-input-moves-map)
	(use-local-map TeX-skak-input-move-map)
	(chess-pos-set-side-to-move (chess-display-position nil)
				    (not for-black)))
      (setq TeX-skak-input-index (chess-display-index nil)
	    TeX-skak-input-marker place)
      (pop-to-buffer (current-buffer))
      (if single-ply
	  (chess-game-add-hook (chess-display-game nil)
			       'TeX-skak-input-handler (current-buffer))
	(message "Enter moves.  Use C-c C-c when you are finish."))
      "")))

(defun TeX-skak-input-handler (game display event &rest args)
  "Event handler for single ply input."
  (when (eq event 'post-move)
    (with-current-buffer display
      (let ((place TeX-skak-input-marker)
	    (ply (chess-game-ply game TeX-skak-input-index)))
	(use-local-map chess-display-mode-map)
	(chess-game-remove-hook game 'TeX-skak-input-handler (current-buffer))
	(pop-to-buffer (marker-buffer place))
	(goto-char place)
	;; The opening brace has already been insert
	(forward-char 1)
	(insert (chess-ply-to-algebraic ply))
	(forward-char 1)
	(let ((chess-display-handling-event nil))
	  (TeX-skak-show-position))))))

(defun TeX-skak-finish-input ()
  "Finish retrieving a list of plies and insert it into the original buffer."
  (interactive)
  (unless (and TeX-skak-input-marker TeX-skak-input-index)
    (error "Display is not in TeX-skak move input mode"))
  (let ((plies (nthcdr TeX-skak-input-index
		       (chess-game-plies (chess-display-game nil))))
	(for-black (not (chess-game-side-to-move (chess-display-game nil)
						 TeX-skak-input-index)))
	(seq (/ (+ 2 TeX-skak-input-index) 2))
	(place TeX-skak-input-marker))
    (use-local-map chess-display-mode-map)
    (pop-to-buffer (marker-buffer place))
    (goto-char place)
    ;; The opening brace has already been insert
    (forward-char 1)
    (while plies
      (unless for-black
	(when (chess-ply-changes (car plies))
	  (insert (format "%d. %s" seq (chess-ply-to-algebraic (car plies)))))
	(setq plies (cdr plies) seq (1+ seq)))
      (when plies
	(when (chess-ply-changes (car plies))
	  (when for-black
	    (insert (format "%d..." seq))
	    (setq for-black nil seq (1+ seq)))
	  (insert (format " %s" (chess-ply-to-algebraic (car plies)))))
	(setq plies (cdr plies)))
      (and plies (chess-ply-changes (car plies))) (insert ? ))
    (forward-char 1)
    (TeX-skak-show-position)))

(defun TeX-skak-insert-newgame ()
  "Insert a \\newgame macro."
  (interactive)
  (TeX-insert-macro "newgame")
  (forward-char 1))

(defun TeX-skak-insert-mainline ()
  "Insert some mainline moves.
The current position will pop up and you can perform the moves you
wish to include in this mainline statement.  After you finish, finalise
insertion using \\[TeX-skak-finish-input]."
  (interactive)
  (TeX-insert-macro "mainline"))

(defun TeX-skak-insert-variation ()
  "Insert a variation.
The current position will pop up and you can perform the moves you
wish to include in this variation.  After you finish, finalise
insertion using \\[TeX-skak-finish-input]."
  (interactive)
  (TeX-insert-macro "variation"))

(defun TeX-skak-insert-hidemoves ()
  "Insert a hidemoves statement.
The current position will pop up and you can perform the moves you
wish to include in this hidemoves statement.  After you finish, finalise
insertion using \\[TeX-skak-finish-input]."
  (interactive)
  (TeX-insert-macro "hidemoves"))

(defun TeX-skak-insert-wmove ()
  "Insert a single ply for White."
  (interactive)
  (TeX-insert-macro "wmove"))

(defun TeX-skak-insert-bmove ()
  "Insert a single ply for Black."
  (interactive)
  (TeX-insert-macro "bmove"))

(provide 'TeX-skak)
;;; tex-skak.el ends here
