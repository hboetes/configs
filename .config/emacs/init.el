(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(colon-double-space t)
 '(column-number-mode t)
 '(git-commit-summary-max-length 1023)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries 'left)
 '(indicate-empty-lines t)
 '(line-number-mode 1)
 '(mode-require-final-newline nil)
 '(mouse-autoselect-window t)
 '(package-archives
   '(("gelpa" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(0blayout airline-themes async auto-package-update catppuccin-theme
              creamsody-theme eterm-256color ethan-wspace fish-mode
              gruvbox-theme ini-mode json-mode lua-mode markdown-mode
              meson-mode nftables-mode nginx-mode pager puppet-mode
              qml-mode smart-mode-line smart-mode-line-powerline-theme
              tree-sitter tree-sitter-indent tree-sitter-langs))
 '(safe-local-variable-values
   '((epa-file-cache-passphrase-for-symmetric-encryption . 1)
     (add-log-time-zone-rule . t)))
 '(send-mail-function 'sendmail-send-it)
 '(sentence-end-double-space t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(transient-mark-mode 1)
 '(visible-cursor nil)
 '(w3m-fill-column 80)
 '(w3m-home-page "https://google.com")
 '(w3m-key-binding 'info)
 '(warning-suppress-log-types '((:warning) (:warning) (comp)))
 '(warning-suppress-types '((:warning) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "monofur for Powerline" :foundry "unci" :slant normal :weight normal :height 158 :width normal))))
 '(ethan-wspace-face ((t (:background "darkslategray")))))

;; Fix a few bugs.
(add-hook 'term-mode-hook #'eterm-256color-mode)

;; This fixes UTF-8 chars in emacsclient
(defun my-terminal-keyboard-coding-system (&optional frame)
  "Force the terminal `keyboard-coding-system' to be `utf-8'.

Prevents terminal frames using a coding system based on the locale.
See info node `(emacs) Terminal Coding'."
  (with-selected-frame (or frame (selected-frame))
    (unless window-system
      (set-keyboard-coding-system 'utf-8))))

;; This fixes UTF8 chars in emacsclient
(defun my-terminal-keyboard-coding-system (&optional frame)
  "Force the terminal `keyboard-coding-system' to be `utf-8'.

Prevents terminal frames using a coding system based on the locale.
See info node `(emacs) Terminal Coding'."
  (with-selected-frame (or frame (selected-frame))
    (unless window-system
      (set-keyboard-coding-system 'utf-8))))

;; Run now, for non-daemon Emacs…
(my-terminal-keyboard-coding-system)
;; …and later, for new frames/emacsclient
(add-hook 'after-make-frame-functions 'my-terminal-keyboard-coding-system)


;; Disable various bars
(menu-bar-mode -1)
(if (fboundp 'scroll-bar-mode)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      ))

(require 'package)
(package-initialize)
(cond
 ((>= emacs-major-version 27)
  (progn
    (setq config-path "~/.config/emacs")))
 ((eql emacs-major-version 26)
  (progn
    (setq config-path "~/.emacs.d"))))

(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

(setq
 auto-package-update-interval 7
 auto-package-update-hide-results t
 auto-package-update-delete-old-versions t)

(require 'ethan-wspace)
(global-ethan-wspace-mode 1)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;; Lots of settings.
(setq backup-by-copying-when-linked t)

;; Don't read system-init files and don't show the splash-screen
;; etc etc etc. In other words…
;;
;; SHUT UP!
(setq
 inhibit-default-init 1
 inhibit-startup-message 1
 initial-scratch-message "")
(defun display-startup-echo-area-message () (message ""))

;; replace yes or no with y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; Automatically invoke ``font-lock-mode'' for all major modes.
;; Set maximum syntax highlighting.
(setq global-font-lock-mode 1)
;; Set the highlighted regions when copying
(setq transient-mark-mode 1)
;; Enable highlighting when searching
(setq search-highlight 1)
;; To highlight matches when using search and replace
(setq query-replace-highlight 1)
;; Show the column and line numbers
(setq line-number-mode 1)
(setq column-number-mode 1)

;; emacs bugs mailinglist: C-h f now permanently loads ~2MB
(setq help-C-source-directory nil)

;; Automatic opening and saving of gzipped files.
(setq auto-compression-mode 1)

;; 8 space tabs for display of literal <TAB> characters
(setq tab-width 8)
;; 8 space tabs are inserted when you press <TAB> in certain modes.
(setq default-tab-stop-list 8)

;; sh indent settings
(setq sh-indent-comment t
      sh-learn-basic-offset t)

;; I do want to be able to edit patches and also diffs.
(setq diff-default-read-only nil)

;; Control backups
(setq make-backup-files nil)

;; some random selfexplanatory settings.
(setq
 indent-tabs-mode nil
 sentence-end-double-space nil
 term-mode-hook nil
 diff-switches "-u"
 vc-follow-symlinks 1)

;; If only it would work all the time.
(setq save-place-mode 1)

;; Save all tempfiles in $TMPDIR/emacs$UID/, the same dir as the emacs
;; server uses. It's nice to have all the mess in the same place.
(defconst emacs-tmp-dir
  (format "%s%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq
 backup-directory-alist `((".*" . , emacs-tmp-dir))
 auto-save-file-name-transforms `((".*" , emacs-tmp-dir t))
 auto-save-list-file-prefix emacs-tmp-dir
 tramp-auto-save-directory emacs-tmp-dir)

;; Spelling
(setq-default ispell-program-name "hunspell")
;; Most stuff I spellcheck is in German.
(setq ispell-local-dictionary "deutsch")

(defun ispell-nederlands ()
  "Saves a lot of keystrokes"
  (interactive)
  (ispell-change-dictionary "nederlands") )

(defun ispell-english ()
  "Saves a lot of keystrokes"
  (interactive)
  (ispell-change-dictionary "english") )

(defun ispell-deutsch ()
  "Saves a lot of keystrokes"
  (interactive)
  (ispell-change-dictionary "deutsch") )

;; Find non ascii chars
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))


;; Enable `a' in dired-mode, to open files/dirs in the same buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Automatically change serials in named zone files.
(autoload 'dns-mode "dns-mode" "Major mode for viewing named zone files." t)
(add-to-list 'auto-mode-alist '("/etc/bind/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/named/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/nsd/zones/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/tmp/boetes*.org" . dns-mode))

;; Post for email-editing with mutt
(autoload 'post-mode "post.el" "Mode for editing
      email-messages" t)
(add-to-list 'auto-mode-alist '("\\mutt-" . post-mode))
(add-to-list 'auto-mode-alist '("pan_edit_"  . post-mode))
(setq post-uses-fill-mode nil post-emoticon-pattern
      (quote ("[0O(<{}]?[;:8B|][.,]?[-+^*o0O][{<>/|]?[][)>(<|/P][)>]?"
              "\\s [(<]?[][)>(<|/][}<>/|]?[-+^*oO0][,.]?[:8][0O>]?"
              "\\s [;:][][P)/(DS]" "\\s [][)(P/][:;]"
              "<[Gg]>"
              "<[BbSs][Gg]>")))

;; mutt-mode
(autoload 'muttrc-mode "muttrc-mode.el"
  "Major mode to edit muttrc files" t)
(add-to-list 'auto-mode-alist '("\\.mutt" . muttrc-mode))

;; Html helpermode
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))

;; No tabs by default. modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)

;; OpenBSD specific code.
(if (eq system-type 'berkeley-unix)
    (setq insert-directory-program "gls"))

;; Functions
;; Mon Feb 24, 2020  7:34 PM
(defun insert-date-at-this-point ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")) )

(defun do-nothing ()
  "Just to remind me this keybind is not used anymore."
  (interactive)
  (message "Hi! :-)") )

(defun zsh-shell ()
  "Start a term with zsh as shell"
  (interactive)
  (term "zsh"))

(defun unix-werase-or-kill (arg)
  "Kill last word with c-w if no region is selected."
  (interactive "*p")
  (if (and transient-mark-mode
           mark-active)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word arg)))

;; Wanted to use this so often. So I made it. :-) with help on
;; #emacs from paakku
(defun select-until-end-of-line ()
  "Select until the end of a line without killing it."
  (interactive)
  (copy-region-as-kill (point) (line-end-position)) )

;; Mail stuff
(setq
 user-full-name "Han Boetes"
 user-mail-address "han@boetes.org")
(defun insert-email ()
  "Insert the users email address"
  (interactive)
  (insert user-full-name " <" user-mail-address ">") )

(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun recenter-to-first-line ()
  "Recenter to the first screenline."
  (interactive)
  (recenter "1"))
(global-set-key "\C-cl" 'recenter-to-first-line)


(defun KNF-c-style ()
  "OpenBSD KNF C-style."
  (interactive)
  (local-set-key "\C-c\C-c" 'compile)
  (c-set-style "bsd")
  (setq fill-column 80)
  (c-set-offset 'arglist-cont '*)
  (c-set-offset 'arglist-cont-nonempty '*)
  (c-set-offset 'statement-cont '4) )
(add-hook 'c-mode-common-hook 'KNF-c-style)

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (setq fill-column 80)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t) )

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;; Keybinds
;; Set a global goto line
(global-set-key "\C-xg"       'goto-line)
(global-set-key "\C-x\C-g"    'goto-line)
;; I want mouseyanks to be inserted at the cursor.
(global-set-key [mouse-2]     'yank)
;; I type too fast.
(global-set-key "\C-x\C-k"    'kill-buffer)
;; replace c-x c-q with something more usefull
(global-set-key  "\C-x\C-q"   'save-buffers-kill-emacs)
(global-set-key  "\C-cr"      'delete-rectangle)
;; Set a global key for autoformat region
(global-set-key (kbd "C-c k") 'text-autoformat-region)
(global-set-key  [f9]         'select-until-end-of-line)
(global-set-key "\C-w"        'unix-werase-or-kill)
(global-set-key (kbd "<C-right>")  'windmove-right)
(global-set-key (kbd "<C-left>")   'windmove-left)
(global-set-key (kbd "<C-up>")     'windmove-up)
(global-set-key (kbd "<C-down>")   'windmove-down)

(global-set-key [insertchar]       'do-nothing)



;; Themes and stuff: m-x describe-face
;; Yes, all themes are safe. >:-(
(setq custom-safe-themes t)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))


;; Theme for the toolbar:
(require 'airline-themes)
;;(load-theme 'airline-base16_woodland t)
(load-theme 'airline-base16_black_metal_venom t)
;;(load-theme 'creamsody t)
;;(load-theme 'creamsody-dark t)
;; (load-theme 'kanagawa t)
(load-theme 'modus-vivendi t)
;(load-theme 'catppuccin t)

;; This makes text from an emacs console windows c&p able without
;; trailing whitespace.
(unless window-system (custom-set-faces   '(default ((t (:background "unspecified-bg"))))))


;; Automatically load the right language: https://oylenshpeegul.gitlab.io/blog/posts/20230206/
(cond
 ((>= emacs-major-version 29)
  (progn
    (require 'eglot)
    (add-hook 'go-mode-hook 'eglot-ensure)
    ;; For current frame
    (set-frame-parameter nil 'alpha-background 90)
    ;; For all new frames henceforth
    (add-to-list 'default-frame-alist '(alpha-background . 90))
    )))

;; filetypes with default mode
(add-to-list 'auto-mode-alist '("fonts.conf" . xml-mode))
(add-to-list 'auto-mode-alist '("Pkgfile"    . sh-mode))
(add-to-list 'auto-mode-alist '("\\.doit"    . sh-mode))

;; tree-sitter stuff
(require 'tree-sitter)
(require 'tree-sitter-langs)
(require 'tree-sitter-indent)

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(defun process-files-indent-untabify-recursive (directory)
  "Process all files in DIRECTORY and its subdirectories by running indent-region and untabify."
  (interactive "DDirectory: ")
  (let ((files (directory-files directory t)))
    (dolist (file files)
      (cond
       ;; Skip . and ..
       ((string-match "\\.$" file) nil)
       ;; Recurse into directories
       ((file-directory-p file)
        (process-files-indent-untabify-recursive file))
       ;; Process regular files
       ((file-regular-p file)
        (with-current-buffer (find-file-noselect file)
          (message "Processing %s" file)
          ;; Run indent-region
          (indent-region (point-min) (point-max))
          ;; Run untabify on the entire buffer
          (untabify (point-min) (point-max))
          ;; Save and close
          (save-buffer)
          (kill-buffer)))))))
