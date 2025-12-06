;;; ui-config.el --- UI configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; User interface configuration and theming

;;; Code:

;; Font configuration
(set-face-attribute 'default nil
                    :family "Monospace"
                    :height 110)

;; Theme
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-minor-modes nil
        doom-modeline-enable-word-count nil
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info nil
        doom-modeline-checker-simple-format t
        doom-modeline-vcs-max-length 12
        doom-modeline-env-version t
        doom-modeline-lsp t
        doom-modeline-github nil
        doom-modeline-github-interval (* 30 60)))

;; Icons
(use-package all-the-icons
  :if (display-graphic-p))

;; Dashboard
(use-package dashboard
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs"
        dashboard-startup-banner 'official
        dashboard-center-content t
        dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-set-navigator t
        dashboard-set-init-info t)
  (dashboard-setup-startup-hook))

;; Rainbow delimiters for better parenthesis matching
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight TODO/FIXME/NOTE keywords
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF")
          ("NOTE"   . "#1E90FF")
          ("HACK"   . "#FF8C00"))))

;; Display line numbers in programming modes
(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode conf-mode) . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative))

(provide 'ui-config)
;;; ui-config.el ends here
