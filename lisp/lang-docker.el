;;; lang-docker.el --- Docker configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Docker and Docker Compose development support

;;; Code:

;; Dockerfile mode
(use-package dockerfile-mode
  :mode ("Dockerfile\\'" "\\.dockerfile\\'")
  :config
  (setq dockerfile-mode-command "docker"))

;; Docker compose mode
(use-package docker-compose-mode
  :mode ("docker-compose\\.ya?ml\\'" "docker-compose.*\\.ya?ml\\'"))

;; Docker integration
(use-package docker
  :bind ("C-c d" . docker)
  :config
  (setq docker-command "docker"))

;; Docker tramp for editing files in containers
(use-package docker-tramp
  :after tramp)

;; Flycheck for Dockerfile
(with-eval-after-load 'flycheck
  (when (executable-find "hadolint")
    (flycheck-define-checker dockerfile-hadolint
      "A Dockerfile syntax checker using hadolint."
      :command ("hadolint" "-")
      :standard-input t
      :error-patterns
      ((error line-start
              (file-name) ":" line ":" column " " (message)
              line-end)
       (warning line-start
                (file-name) ":" line ":" column " " (one-or-more not-newline) "DL" (message)
                line-end))
      :modes dockerfile-mode)
    (add-to-list 'flycheck-checkers 'dockerfile-hadolint)))

;; LSP support for Dockerfile
(add-hook 'dockerfile-mode-hook #'lsp-deferred)

;; Useful docker commands
(defun docker-build-current-file ()
  "Build Docker image from current Dockerfile."
  (interactive)
  (let* ((file (buffer-file-name))
         (dir (file-name-directory file))
         (tag (read-string "Image tag: ")))
    (compile (format "docker build -t %s -f %s %s" tag file dir))))

(defun docker-compose-up ()
  "Run docker-compose up in current directory."
  (interactive)
  (compile "docker-compose up"))

(defun docker-compose-down ()
  "Run docker-compose down in current directory."
  (interactive)
  (compile "docker-compose down"))

(with-eval-after-load 'dockerfile-mode
  (define-key dockerfile-mode-map (kbd "C-c C-b") 'docker-build-current-file))

(with-eval-after-load 'docker-compose-mode
  (define-key docker-compose-mode-map (kbd "C-c C-u") 'docker-compose-up)
  (define-key docker-compose-mode-map (kbd "C-c C-d") 'docker-compose-down))

(provide 'lang-docker)
;;; lang-docker.el ends here
