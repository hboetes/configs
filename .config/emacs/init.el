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
   '(auto-package-update rust-mode lsp-mode zenburn-theme magit-delta magit crontab-mode csv-mode yaml-mode eterm-256color airline-themes flycheck ethan-wspace smart-mode-line-powerline-theme smart-mode-line puppet-mode pager nginx-mode async))
 '(safe-local-variable-values
   '((epa-file-cache-passphrase-for-symmetric-encryption . 1)
     (add-log-time-zone-rule . t)))
 '(send-mail-function 'sendmail-send-it)
 '(sentence-end-double-space t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tramp-syntax 'simplified nil (tramp))
 '(transient-mark-mode 1)
 '(w3m-fill-column 80)
 '(w3m-home-page "https://google.com")
 '(w3m-key-binding 'info))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "monofur for Powerline" :foundry "unci" :slant normal :weight normal :height 158 :width normal)))))


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
;; etc etc etc. In other words...
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

;; nice mode for various config-files.
(require 'generic-x)

;; Lets keep things readable
(setq fill-column 72)

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
;; server uses. It's nice to have all mess in the same place.
(defconst emacs-tmp-dir
  (format "%s%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq
 backup-directory-alist `((".*" . , emacs-tmp-dir))
 auto-save-file-name-transforms `((".*" , emacs-tmp-dir t))
 auto-save-list-file-prefix emacs-tmp-dir)

(setq tramp-default-method "sshx"
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


;; Mail stuff
(setq
 user-full-name "Han Boetes"
 user-mail-address "han@boetes.org")

;; For initscripts
(add-to-list 'auto-mode-alist '("/etc/rc*" . sh-mode))
(add-to-list 'auto-mode-alist '("/var/tmp/rc*" . sh-mode))

;; Enable `a' in dired-mode, to open files/dirs in the same buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Automatically change serials in named zone files.
(autoload 'dns-mode "dns-mode" "Major mode for viewing named zone files." t)
(add-to-list 'auto-mode-alist '("/etc/bind/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/named/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/nsd/zones/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/tmp/boetes*.org" . dns-mode))

;; post for email-editing with mutt
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

;; filetypes with default mode
(add-to-list 'auto-mode-alist '("fonts.conf" . xml-mode))
(add-to-list 'auto-mode-alist '("Pkgfile"    . sh-mode))
(add-to-list 'auto-mode-alist '("\\.doit"    . sh-mode))

;; no tabs by default. modes that really need tabs should enable
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
;; Fire up magit
(global-set-key "\C-xy"       'magit-status)
(global-set-key "\C-x\C-y"    'magit-status)
(global-set-key "\C-x\M-y"    'magit-dispatch)
;; I want mouseyanks to be inserted at the cursor.
(global-set-key [mouse-2]     'yank)
;; I type too fast.
(global-set-key "\C-x\C-k"    'kill-buffer)
(global-set-key  [f3]         'term-with-zsh-as-shell)
;; replace c-x c-q with something more usefull
(global-set-key  "\C-x\C-q"   'save-buffers-kill-emacs)
(global-set-key  "\C-cr"      'delete-rectangle)
;; Set a global key for autoformat region
(global-set-key (kbd "C-c k") 'text-autoformat-region)
(global-set-key  [f9]         'select-until-end-of-line)
(global-set-key "\C-c s"      'replace-string)
(global-set-key "\C-c r"      'replace-regex)
(global-set-key "\C-w"        'unix-werase-or-kill)
(global-set-key (kbd "<C-right>")  'windmove-right)
(global-set-key (kbd "<C-left>")   'windmove-left)
(global-set-key (kbd "<C-up>")     'windmove-up)
(global-set-key (kbd "<C-down>")   'windmove-down)

(global-set-key [insertchar]       'do-nothing)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; Themes and stuff: m-x describe-face
;; Yes, all themes are safe. >:-(
(setq custom-safe-themes t)

(cond
 ((>= emacs-major-version 28)
  (progn
    (load-theme 'modus-vivendi t)
    (setq ethan-wspace-face-customized t)
    (custom-theme-set-faces
     'modus-vivendi
     '(ethan-wspace-face ((t (:background "black")))))
    ))
 ((<= emacs-major-version 27)
  (progn
    (load-theme 'zenburn t)
    (custom-theme-set-faces
     'zenburn
     '(font-lock-comment-face ((t (:foreground "#DFAF8F"))))
     '(font-lock-comment-delimiter-face ((t (:foreground "#DFAF8F"))))
     '(region ((t (:extend t :background "peru"))))))))

;; Theme for the toolbar:
(require 'airline-themes)
(load-theme 'airline-ouo t)

(setq
 powerline-utf-8-separator-left        #xe0b0
 powerline-utf-8-separator-right       #xe0b2
 airline-utf-glyph-separator-left      #xe0b0
 airline-utf-glyph-separator-right     #xe0b2
 airline-utf-glyph-subseparator-left   #xe0b1
 airline-utf-glyph-subseparator-right  #xe0b3
 airline-utf-glyph-branch              #xe0a0
 airline-utf-glyph-readonly            #xe0a2
 airline-utf-glyph-linenumber          #xe0a1)

;; This function sets a random theme: You can trigger it with: m-x load-random-theme
(defun load-random-theme ()
  "Load any random theme from the available ones."
  (interactive)

  ;; disable any previously set theme
  (if (boundp 'theme-of-the-day)
      (progn
        (disable-theme theme-of-the-day)
        (makunbound 'theme-of-the-day)))

  (defvar themes-list (custom-available-themes))
  (defvar theme-of-the-day (nth (random (length themes-list))
                                themes-list))
  (load-theme (princ theme-of-the-day) t))
;; (load-random-theme)


(add-hook 'term-mode-hook #'eterm-256color-mode)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

;; Set the size of the floating window.
(add-hook 'before-make-frame-hook
          #'(lambda ()
              (add-to-list 'default-frame-alist '(left   . 0))
              (add-to-list 'default-frame-alist '(top    . 0))
              (add-to-list 'default-frame-alist '(height . 52))
              (add-to-list 'default-frame-alist '(width  . 200))))

;; This makes text from an emacs console windows c&p able without
;; trailing whitespace.
(unless window-system (custom-set-faces   '(default ((t (:background "unspecified-bg"))))))

;; Always enable magit-delta-mode.
(magit-delta-mode)

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
