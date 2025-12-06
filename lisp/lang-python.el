;;; lang-python.el --- Python configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Python development configuration with LSP, virtual environments, testing

;;; Code:

(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (setq python-indent-offset 4
        python-shell-interpreter "python3"))

;; Python LSP with pyright
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Virtual environment management
(use-package pyvenv
  :config
  (setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; Poetry integration
(use-package poetry
  :hook (python-mode . poetry-tracking-mode))

;; Python testing
(use-package python-pytest
  :after python
  :bind (:map python-mode-map
              ("C-c t t" . python-pytest-dispatch)))

;; IPython/Jupyter integration
(use-package ein
  :commands (ein:notebooklist-open))

;; Black formatter
(use-package python-black
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

;; Isort for import sorting
(use-package py-isort
  :after python
  :hook (python-mode . (lambda ()
                         (add-hook 'before-save-hook 'py-isort-before-save nil 'local))))

;; Live python execution
(use-package live-py-mode
  :commands live-py-mode)

;; Conda support
(use-package conda
  :config
  (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t))

;; Python docstring
(use-package sphinx-doc
  :hook (python-mode . sphinx-doc-mode))

(provide 'lang-python)
;;; lang-python.el ends here
