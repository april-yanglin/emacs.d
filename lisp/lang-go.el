;;; lang-go.el --- Go configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Go development configuration with LSP and go-mode

;;; Code:

(use-package go-mode
  :mode "\\.go\\'"
  :hook ((go-mode . lsp-deferred)
         (before-save . gofmt-before-save))
  :config
  (setq gofmt-command "goimports"))

;; Additional Go tools
(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))

(use-package go-guru
  :hook (go-mode . go-guru-hl-identifier-mode))

(use-package go-tag
  :bind (:map go-mode-map
              ("C-c t a" . go-tag-add)
              ("C-c t r" . go-tag-remove)))

;; Go test support
(use-package gotest
  :bind (:map go-mode-map
              ("C-c t t" . go-test-current-test)
              ("C-c t f" . go-test-current-file)
              ("C-c t p" . go-test-current-project)))

;; Go snippets
(use-package go-snippets
  :after yasnippet)

;; Go implementation jumper
(use-package go-impl
  :commands go-impl)

;; Go error checking
(use-package flycheck-golangci-lint
  :hook (go-mode . flycheck-golangci-lint-setup))

;; Fill struct
(use-package go-fill-struct
  :bind (:map go-mode-map
              ("C-c f s" . go-fill-struct)))

;; Go playground
(use-package go-playground
  :commands (go-playground go-playground-mode))

;; Additional go-mode settings
(with-eval-after-load 'go-mode
  (setq go-test-verbose t))

(provide 'lang-go)
;;; lang-go.el ends here
