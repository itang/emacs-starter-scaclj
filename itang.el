;; DESCRIPTION: Custom settings for itang

;; If you installed some executables in non-standard locations, you
;; might need to set the path.
;; http://xahlee.org/emacs/emacs_env_var_paths.html
;;(setenv "PATH"
;;        (concat
 ;;        ".:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/usr/local/scala/bin/scala:/usr/local/git/bin:/usr/local/node/bin" ":"
 ;;        (getenv "PATH")))
;;
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;; Set a default font face
;;(set-face-font 'default "-apple-inconsolata-medium-r-normal--14-0-72-72-m-0-iso10646-1")
;;(set-face-font 'default "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1")
;;(set-face-font 'default "-apple-consolas-medium-r-normal--12-0-72-72-m-0-iso10646-1")
;;(set-face-font 'default "-apple-lucida typewriter-medium-r-normal--12-0-72-72-m-0-iso10646-1")
;;//(set-face-font 'default "-apple-menlo-normal-r-normal--12-0-72-72-m-0-iso10646-1")

;; Line Numbering
(global-linum-mode 1)
(setq linum-format " %d ")

;; Split Windows
(global-set-key [f5] 'split-window-horizontally)
(global-set-key [f6] 'split-window-vertically)
(global-set-key [f7] 'delete-window)

;; Return to previous window layout
;; @itang
;Ctrl-c ←
(when (fboundp 'winner-mode) 
 (winner-mode) 
 (windmove-default-keybindings)) 

;; Bind full screen (only for mac os)
(global-set-key (kbd "M-RET") 'ns-toggle-fullscreen)

;; Toggle Line numbers
(global-set-key [f4] 'linum-mode)

;; Some Mac-friendly key counterparts
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "M-3") "#")

;; Turn on line highlighting everywhere
(global-hl-line-mode 1)
(prefer-coding-system 'utf-8)

;; Don't auto save or create backup files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Don't show the backtrace when an error occurs
(setq debug-on-error nil)

;; Control automatic buffer splitting
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; Stops special buffers stealing an existing one
(push "*Help*" special-display-buffer-names)

;; Prevent shell echoing the input commands
(defun my-comint-init ()
  (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init)

;; Window transaprency
;;(set-frame-parameter nil 'alpha 0.9)

;; Font anti-aliasing
;;(setq mac-allow-anti-aliasing nil)

;; Turn off the annoying visible bell
(setq visible-bell nil)

;; Options for changing around the meta key on mac os
;;(setq mac-command-modifier 'meta) ; standard keyboard, switch in Emacs
;;(setq mac-option-modifier 'meta) ; standard keyboard, use meta again

;; Disable Italic comments
;;(copy-face 'italic  'font-lock-comment-face)
;;      (set-face-italic-p 'font-lock-comment-face nil)
;;      (setq font-lock-comment-face 'font-lock-comment-face)

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)

;; nXhtml
(add-to-list 'load-path  (concat dotfiles-dir "/vendor/nxhtml"))
(load "autostart.el")

;; Color Themes
;; Examples here: http://gnuemacscolorthemetest.googlecode.com/svn/html/index-el.html
(add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme"))
(require 'color-theme)
  (color-theme-initialize)
  (color-theme-charcoal-black)
  ;;(color-theme-gray30)

;; Themes not from color-theme package
(load (concat dotfiles-dir "vendor/color-theme-vibrant-ink.el"))
  ;;(color-theme-vibrant-ink)
(load (concat dotfiles-dir "vendor/color-theme-topfunky.el"))
  ;;(color-theme-topfunky)

;; Auto-complete
(add-to-list 'load-path (concat dotfiles-dir "/vendor/auto-complete"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "/vendor/auto-complete/ac-dict"))
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-start 2)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'js3-mode)
(set-default 'ac-sources
             '(;;ac-source-semantic
               ac-source-yasnippet
               ac-source-abbrev
               ac-source-words-in-buffer
               ac-source-words-in-all-buffer
               ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))

;; YaSnippet
(add-to-list 'load-path (concat dotfiles-dir "/vendor/yasnippet"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet/snippets/text-mode"))
(setq yas/prompt-functions '(yas/dropdown-prompt))

(add-to-list 'load-path (concat dotfiles-dir "/vendor/haml-mode.el"))
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.scaml$" . haml-mode))

(add-to-list 'load-path (concat dotfiles-dir "/vendor/sass-mode.el"))
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; Scala mode
(add-to-list 'load-path (concat dotfiles-dir "/vendor/scala-mode"))
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook '(lambda ()
                              (yas/minor-mode-on)))

;; For replacing unicode characters as you type
;;(load (concat dotfiles-dir "vendor/emacs-rc-pretty-lambda.el"))

;; ENSIME
(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path  (concat dotfiles-dir "/vendor/ENSIME/elisp"))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

