;;; programming-config.el --- General programming setup -*- lexical-binding: t; -*-

;;; Commentary:
;; General programming configuration including LSP, git, projects, snippets

;;; Code:

;; Project management
(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-completion-system 'default
        projectile-enable-caching t
        projectile-indexing-method 'alien))

;; Git integration
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-gutter
  :diminish git-gutter-mode
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.5))

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode))
  :config
  (diff-hl-flydiff-mode))

;; LSP Mode
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-completion-provider :capf
        lsp-idle-delay 0.500
        lsp-log-io nil
        lsp-enable-snippet t
        lsp-enable-on-type-formatting nil
        lsp-enable-indentation nil
        lsp-enable-symbol-highlighting t
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t
        lsp-modeline-code-actions-enable t
        lsp-modeline-diagnostics-enable t
        lsp-headerline-breadcrumb-enable t
        lsp-semantic-tokens-enable t
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all nil))

(use-package lsp-ui
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-delay 0.5
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t))

;; Treesitter for better syntax highlighting
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

;; Company mode for completion
(use-package company
  :diminish company-mode
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0
        company-show-numbers t
        company-tooltip-align-annotations t
        company-selection-wrap-around t
        company-transformers '(company-sort-by-occurrence))
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection)
              ("TAB" . company-complete-selection)
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Flycheck for syntax checking
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-display-errors-delay 0.3))

;; Yasnippet for code snippets
(use-package yasnippet
  :diminish yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

;; Comment/uncomment easily
(use-package evil-nerd-commenter
  :bind (("M-;" . evilnc-comment-or-uncomment-lines)))

;; Smart parentheses
(use-package smartparens
  :diminish smartparens-mode
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config))

;; Editorconfig support
(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

;; Format all - code formatting
(use-package format-all
  :commands format-all-buffer
  :bind (("C-c f" . format-all-buffer)))

;; Rainbow mode for color codes
(use-package rainbow-mode
  :diminish rainbow-mode
  :hook ((prog-mode text-mode) . rainbow-mode))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(provide 'programming-config)
;;; programming-config.el ends here
