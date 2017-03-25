(setq inhibit-default-init 1
      inhibit-startup-message 1
      inhibit-startup-echo-area-message (user-login-name)
      initial-scratch-message "")

(custom-set-variables
 '(bookmark-save-flag 1)
 '(c-basic-offset 4)
 '(change-log-default-name "+ ")
 '(compilation-context-lines 2)
 '(compilation-read-command t)
 '(compilation-scroll-output (quote first-error))
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(ispell-program-name "aspell" t)
 '(ispell-skip-html t)
 '(mail-host-address "axis-simulation.com")
 '(minibuffer-auto-raise t)
 '(mouse-wheel-mode t nil (mwheel))
 '(scroll-bar-mode (quote right))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(user-mail-address concat((user-login-name)(mail-host-address)))
 )

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:stipple nil :background "dark slate grey" :foreground "pale goldenrod" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 123 :width normal :family "7x14"))))
;;  '(diff-added ((t (:inherit diff-changed :foreground "green"))))
;;  '(diff-context ((((class color grayscale) (min-colors 88)) (:inherit shadow))))
;;  '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:background "grey60" :weight bold))))
;;  '(diff-header ((((class color) (min-colors 88) (background dark)) (:background "grey60"))))
;;  '(diff-hunk-header ((t (:inherit diff-header :foreground "pink" :underline t :weight bold))))
;;  '(diff-removed ((t (:inherit diff-changed :foreground "red"))))
;; )

;; show matching parenthesis
(require 'paren)
(show-paren-mode 1)

;; display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; highlight text regions
(setq transient-mark-mode t)

;; Windows-like selection and key bindings
(pc-bindings-mode)
(pc-selection-mode)
(delete-selection-mode 1)

;; force to use backup directory instead of writing
;; backups into the current dir
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/autosaves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; hippie expand
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(
					; try-expand-all-abbrevs ; looks through all abbrev-tables
	try-expand-dabbrev ; works exactly as dabbrev-expand
	try-expand-dabbrev-visible ; searches the currently visible parts of all windows
	try-expand-dabbrev-all-buffers ; searches in all buffers
	try-expand-dabbrev-from-kill ; searches the kill ring for a suitable completion
	try-complete-file-name-partially ; only as many characters as is unique
	try-complete-file-name ; goes through all possible completions

	try-expand-line ; searches for an entire line
	try-expand-line-all-buffers ; searches in all buffers
	try-expand-list ; back to the nearest open delimiter, to a whole list
	try-expand-list-all-buffers ; searches in all buffers
	try-expand-whole-kill ; tries to complete with a whole entry from the kill ring
	try-complete-lisp-symbol ; like lisp-complete-symbol
	try-complete-lisp-symbol-partially ; completion of what is unique in the name
	))

;; my keybindings
(global-set-key "\C-x\C-l" 'goto-line)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-s" 'query-replace)
(global-set-key "\C-cr" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

(global-set-key [(C-return)] 'hippie-expand)
(global-set-key (kbd "TAB") 'hippie-expand)
(global-set-key [(f2)] 'speedbar-get-focus)
(global-set-key "\C-cc" 'compile)

;; set titles for frame and icon (%f == file name, %b == buffer name)
(setq-default frame-title-format (list "Emacs - [%f]"))
(setq-default icon-title-format "Emacs - [%b]")

(setq initial-frame-alist '((left . 120) (top . 0) (width . 90) (height . 69)))
(set-default-font "7x14")

;; scrolling
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 20)
(setq scroll-preserve-screen-position t)

;; saveplace - Automatically save cursor position in files
(require 'saveplace)
(setq-default save-place t)

;; add "~/.elisp" and "~/elisp" to load path if they exist
(if (file-readable-p "~/.elisp")
    (add-to-list 'load-path "~/.elisp")
  (if (file-readable-p "~/elisp")
      (add-to-list 'load-path "~/elisp")))

;; loads ido-library
(when (locate-library "ido")
  (require 'ido)
  (ido-mode t)
  )

(defun insert-user-mail-address () (interactive)
       (insert user-mail-address)
       )

(defun insert-block-comment ()
  (interactive)
  (beginning-of-line)
  (insert "/**") (indent-according-to-mode)
  (insert "\n* ") (indent-according-to-mode)
  (insert "\n*/") (indent-according-to-mode)
  (insert "\n")
  (end-of-line -1))

(defun insert-file-name () (interactive)
       (require 'dired)
       (insert (buffer-name)))

(defun insert-date ()  (interactive)
       (insert (shell-command-to-string "date +%Y-%d-%m"))
       (end-of-line -0)
       )

(defun insert-date-rfc-2822 ()  (interactive)
       (insert (shell-command-to-string "date --rfc-2822"))
       (end-of-line -0)
       )

(defun insert-date-lexical ()  (interactive)
       (insert (shell-command-to-string "date +'%a %b %d %Y'"))
       (end-of-line -0)
       )

(defun insert-year ()  (interactive)
       (insert (shell-command-to-string "date +%Y"))
       (end-of-line -0)
       )

(defun insert-axis-header () (interactive)
       (insert "//\n")
       (insert "// Copyright (C) ")(insert-year) (insert "\n")
       (insert "// Axis Flight Training Systems GmbH\n")
       (insert "//\n\n"))

(defun insert-changelog-entry (v) (interactive "*sVersion: ")
       (insert "Version " v " @ ") (insert-date) (insert " <") (insert user-mail-address) (insert ">\n")
       ;;(end-of-line -1)
       (insert "\n")
       (insert "\t* "))

(defun insert-rpm-changelog-entry (v) (interactive "*sVersion: ")
       (insert "* ") (insert-date-lexical)
       ;;(end-of-line -1)
       (insert " ") (insert user-full-name) (insert " <") (insert user-mail-address) (insert "> " v "\n")
       (insert "- "))

(defun insert-debian-changelog-entry () (interactive)
       (insert "<module> (<version>) unstable; urgency=low\n\n")
       (insert "  * <description>\n\n")
       (insert " -- ") (insert user-full-name) (insert " <") (insert user-mail-address) (insert ">  ") (insert-date-rfc-2822)
       (insert "\n\n")
       (end-of-line -5)
       )

(defun insert-namespace (ns) (interactive "*sNamespace: ")
       "Inserts a C++ namespace declaration"
       (insert "namespace " ns ) (insert " {\n\n\n" ) (indent-according-to-mode)
       (insert "} // end namespace " ns ) (indent-according-to-mode)
       (insert "\n" ) (indent-according-to-mode)
       (end-of-line -1) (indent-according-to-mode)
       )

(defun insert-class (cn) (interactive "*sClass: ")
       "Inserts a C++ class declaration"
       (insert "class " cn ) (insert " {\n" ) (indent-according-to-mode)
       (insert "public:" ) (insert "\n" ) (indent-according-to-mode)
       (insert cn "();\n" ) (indent-according-to-mode)
       (insert "~" cn "();\n\n" ) (indent-according-to-mode)
       (insert "private:" ) (insert "\n\n" ) (indent-according-to-mode)
       (insert "}; // end class " cn ) (indent-according-to-mode)
       (insert "\n" ) (indent-according-to-mode)
       (end-of-line -1) (indent-according-to-mode)
       )

;; generate javadoc
(defun java-insert-javadoc ()
  (interactive)
  (beginning-of-line)
  (insert "/**") (indent-according-to-mode)
  (insert "\n* ") (indent-according-to-mode)
  (insert "\n*/") (indent-according-to-mode)
  (insert "\n")
  (end-of-line -1))


;; disable the annoying beeps
(setq visible-bell t)

(defun my-c-mode-settings ()

  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-ci" 'indent-region)
  (local-set-key "\M-p" 'previous-error)
  (local-set-key "\M-n" 'next-error)
  (local-set-key "\M-m\M-c" 'tempo-template-html-code)
  (local-set-key "\M-m\M-b" 'tempo-template-html-bold)
  (local-set-key "\M-m\M-i" 'tempo-template-html-italics)
  (local-set-key "\M-m\M-j" 'java-insert-javadoc)
  (local-set-key "\M-m\M-l" 'tempo-template-html-listitem)
  (local-set-key "\M-m\M-n" 'insert-namespace)
  (local-set-key "\M-m\M-m" 'insert-class)

  (local-set-key [(C-f1)] 'man-follow)

  (local-set-key "\C-c\C-c" (function (lambda () (interactive)
					(compile "cd .. && make -j2 all "))))
  (local-set-key "\C-c\C-v" (function (lambda () (interactive)
					(compile "cd .. && make -j2 check "))))
  (local-set-key "\C-cv" (function (lambda () (interactive)
				     (compile "cd .. && make && ctest -V "))))
  (local-set-key "\C-c\C-t" (function (lambda () (interactive)
					(compile "cd .. && make && ctest"))))

  (local-set-key "\M-m\M-o" 'tempo-template-c++-cout)
  (local-set-key "\M-m\M-p" 'tempo-template-c++-endl)

  (define-key  c++-mode-map "\C-co" 'ff-find-other-file)
  (define-key  c-mode-map "\C-co" 'ff-find-other-file)

  (setq compilation-finish-function
	(lambda (buf str)
	  (if (string-match "exited abnormally" str)
	      ;;there were errors
	      (message "compilation errors, press C-x ` to visit")
	    ;;no errors, make the compilation window go away in 0.5 seconds
	    (run-at-time 1.5 nil 'delete-windows-on buf)
	    (message "NO COMPILATION ERRORS!")
	    )
	  )
	)

  ;; make backspace consume all whitespaces
  (c-toggle-hungry-state t)

  ;; use spaces instead of tabs
  (setq indent-tabs-mode nil)

  )

(require 'find-file)
(setq ff-always-try-to-create nil)
(setq cc-other-file-alist
      '((".c$" (".h" ".hpp"))
	(".cpp$" (".hpp" ".h"))
	(".hpp$" (".cpp" ".c"))
	(".h$" (".c" ".cpp"))
	))

(setq cc-search-directories
      '(
	"."
	"../incl/"
	"../include/"
	"../src/"
	))

(require 'git)
(require 'cmake-mode)

(setq auto-mode-alist
      '(("\\.cc\\'" . c++-mode)
	("\\.hh\\'" . c++-mode)
	("\\.hpp\\'" . c++-mode)
	("\\.[cC]\\'" . c++-mode)
	("\\.[hH]\\'" . c++-mode)
	("\\.cpp\\'" . c++-mode)
	("\\.[cC][xX][xX]\\'" . c++-mode)
	("\\.hxx\\'" . c++-mode)
	("\\.c\\+\\+\\'" . c++-mode)
	("\\.h\\+\\+\\'" . c++-mode)
	("\\.xml\\'" . sgml-mode)
	("\\.xsd\\'" . sgml-mode)
	("\\.sh\\'" . shell-script-mode)
	("\\.pl\\'" . perl-mode)
	("\\.pm\\'" . perl-mode)
	("\\.el\\'" . lisp-mode)
	("\\.emacs\\'" . lisp-mode)
	("\\.ad[bs]\\'" . ada-mode)
	("\\.sh\\'" . shell-script-mode)
	("\\.am\\'" . makefile-mode)
	("\\makefile\\'" . makefile-mode)
	("\\Makefile\\'" . makefile-mode)
	("\\.in\\'" . autoconf-mode)
	("\\configure\\'" . autoconf-mode)
	("\\ChangeLog\\'" . change-log-mode)
	("\\changelog\\'" . change-log-mode)
	("\\CMakeLists.txt\\'" . cmake-mode)
	("\\.cmake\\'" . cmake-mode)
	("\\.tcl\\'" . tcl-mode)
	("\\.py\\'" . python-mode)
	("\\.java\\'" . java-mode)
	("\\.tex\\'" . latex-mode)
	("\\.pdf\\'" . doc-view-mode)
	("\\.ps\\'" . doc-view-mode)

	))

(add-hook 'c-mode-hook 'my-c-mode-settings)
(add-hook 'c++-mode-hook 'my-c-mode-settings)
