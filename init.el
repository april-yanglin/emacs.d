;;; init.el --- Emacs Configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Main Emacs configuration file
;; Supports: Python, Go, Java, C++, CUDA, Docker, Frontend, Org, Markdown, CSV, Parquet

;;; Code:

;; Add lisp directory to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Package management
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-expand-minimally t
      use-package-compute-statistics t)

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
