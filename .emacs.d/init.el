(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(colon-double-space t)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "" default)))
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (ethan-wspace mediawiki apache-mode psession smart-mode-line-powerline-theme smart-mode-line auto-package-update puppet-mode pager php-mode nginx-mode yaml-mode async auto-complete paradox crontab-mode)))
 '(paradox-automatically-star t)
 '(safe-local-variable-values (quote ((add-log-time-zone-rule . t))))
 '(send-mail-function (quote sendmail-send-it))
 '(sentence-end-double-space t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tidy-menu-lock nil)
 '(tool-bar-mode nil)
 '(w3m-fill-column 80)
 '(w3m-home-page "http://boetes.org")
 '(w3m-key-binding (quote info)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "monofur for Powerline" :foundry "unknown" :slant normal :weight normal :height 151 :width normal)))))

(require 'package)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

(psession-mode 1)

;; Those \ at the end of long lines...
;;(set-default 'truncate-lines t)

                                        ; (setq debug-on-error t)
(setq backup-by-copying-when-linked t)

;; Options

;; Don't read system-init files and don't show the splash-screen
;; etc etc etc. In other words...
;;
;; SHUT UP!
(setq inhibit-default-init 1
      inhibit-startup-message 1
      initial-scratch-message "")
(defun display-startup-echo-area-message () (message ""))


(setq load-path (append load-path '("~/.emacs.d/lisp/")))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'Amelie t)

(icomplete-mode 1)

(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

;; replace yes or no with y or n
(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively 50
      scroll-preserve-screen-position nil)

;; Automatically invoke ``font-lock-mode'' for all major modes.
;; Set maximum syntax highlighting.
(global-font-lock-mode 1)
;; Set the highlighted regions when copying
(setq transient-mark-mode 1)
;; Enable highlighting when searching
(setq search-highlight 1)
;; To highlight matches when using search and replace
(setq query-replace-highlight 1)
;; Show the column and line numbers
(setq line-number-mode 1)
(setq column-number-mode 1)

;; (setq inhibit-field-text-motion 1)

;; emacs bugs mailinglist: C-h f now permanently loads ~2MB
(setq help-C-source-directory nil)

;; Automatic opening and saving of gzipped files.
(auto-compression-mode 1)

;; 8 space tabs for display of literal <TAB> characters
(setq tab-width 8)
;; 8 space tabs are inserted when you press <TAB> in certain modes.
(setq default-tab-stop-list 8)

;; Toggle on ``Just-in-time'' lock mode to make it faster. New with
;; emacs21
(require 'jit-lock)
(setq jit-lock-stealth-time 1)

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
 ;; isearch-allow-scroll t
 diff-switches "-u"
 vc-follow-symlinks 1)

;; If only it would work all the time.
(setq-default save-place t)

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
(setq-default ispell-program-name "aspell")
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

;; For cvs changelog files
(add-to-list 'auto-mode-alist '("cvs*" . text-mode))

;; Enable `a' in dired-mode, to open files/dirs in the same buffer.
(put 'dired-find-alternate-file 'disabled nil)

;; Automatically change serials in named zone files.
(autoload 'dns-mode "dns-mode" "Major mode for viewing named zone files." t)
(add-to-list 'auto-mode-alist '("/etc/bind/*" . dns-mode))
(add-to-list 'auto-mode-alist '("/var/named/*" . dns-mode))
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

;; mode for crontabs
(autoload 'crontab-mode "crontab-mode.el" "crontab-mode" t)
(add-to-list 'auto-mode-alist '("crontab\\." . crontab-mode))

;; no tabs by default. modes that really need tabs should enable
;; indent-tabs-mode explicitly. makefile-mode already does that, for
;; example.
(setq-default indent-tabs-mode nil)

;; If we're running X
(if (eq window-system 'x)
    (progn
      (scroll-bar-mode)
      (menu-bar-mode 1)
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (blink-cursor-mode 'nil)
      (setq
       mouse-yank-at-point nil))
  (progn
    (set-face-foreground 'mode-line "black")
    (set-face-background 'mode-line "white")
    (menu-bar-mode -1)) )

(set-face-background 'mode-line "yellow")

(when (string-match "difool" (system-name))
  (set-face-background 'mode-line "yellow"))
(when (string-match "tara" (system-name))
  (set-face-background 'mode-line "green"))

(set-face-inverse-video 'mode-line t)

;; OpenBSD specific code.
(if (eq system-type 'berkeley-unix)
    (setq ls-lisp-use-insert-directory-program t
          insert-directory-program "gls"))

;; Functions
(defun insert-date-at-this-point ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")) )

(defun do-nothing ()
  "Just to remind me this keybind is not used anymore."
  (interactive)
  (message "Hi! :-)") )

(defun term-with-zsh-as-shell ()
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

(defun text-autoformat-region ()
  "Call Text::Autoformat interactively on region"
  (interactive)
  (shell-command-on-region
   (region-beginning) (region-end)
   "perl -MText::Autoformat -e \"{autoformat{all=>1, renumber=>0, justify=>'full',
   left=>0, right=>72};}\""
   (current-buffer) t) )

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

;; Keybinds
;; Set a global goto line
(global-set-key "\C-xg"       'goto-line)
(global-set-key "\C-x\C-g"    'goto-line)
;; I want mouseyanks to be inserted at the cursor.
(global-set-key [mouse-2]     'yank)
;; I type too fast.
(global-set-key "\C-x\C-k"    'kill-buffer)
;; terminal
(global-set-key  [f3]         'term-with-zsh-as-shell)
;; replace c-x c-q with something more usefull
(global-set-key  "\C-x\C-q"   'save-buffers-kill-emacs)
(global-set-key  "\C-cr"   'delete-rectangle)
;; Set a global key for autoformat region
(global-set-key (kbd "C-c k") 'text-autoformat-region)
(global-set-key  [f9]         'select-until-end-of-line)
(global-set-key "\C-c s" 'replace-string)
(global-set-key "\C-c r" 'replace-regex)
(global-set-key "\C-w" 'unix-werase-or-kill)
(global-set-key (kbd "<C-right>")  'windmove-right)
(global-set-key (kbd "<C-left>")   'windmove-left)
(global-set-key (kbd "<C-up>")     'windmove-up)
(global-set-key (kbd "<C-down>")   'windmove-down)

(global-set-key [insertchar]       'do-nothing)

;; These two lines are just examples
(setq powerline-arrow-shape 'arrow)
;; These two lines you really need.
(setq sml/theme 'powerline)
(sml/setup)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

(require 'ethan-wspace)
(global-ethan-wspace-mode 1)
