;;; init.el --- Emacs Configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Main Emacs configuration file
;; Supports: Python, Go, Java, C++, CUDA, Docker, Frontend, Org, Markdown, CSV, Parquet

;;; Code:

;; Add lisp directory to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Configure straight.el
(setq straight-use-package-by-default t
      straight-vc-git-default-clone-depth 1
      straight-check-for-modifications '(check-on-save find-when-checking))

;; Install use-package via straight
(straight-use-package 'use-package)

;; Configure use-package
(setq use-package-always-defer t
      use-package-expand-minimally t
      use-package-compute-statistics t
      use-package-enable-imenu-support t)

;; Load configuration modules
(require 'base-config)
(require 'evil-config)            ; Evil mode with space leader
(require 'evil-local-leader)      ; Major-mode specific bindings with comma
(require 'ui-config)
(require 'programming-config)
(require 'lang-python)
(require 'lang-go)
(require 'lang-java)
(require 'lang-cpp)
(require 'lang-cuda)
(require 'lang-docker)
(require 'lang-frontend)
(require 'writing-config)
(require 'data-config)

;;; init.el ends here
