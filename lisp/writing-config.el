;;; writing-config.el --- Writing and documentation configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration for Org mode, Markdown, and other writing tools

;;; Code:

;;; Org Mode
(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-directory "~/org"
        org-default-notes-file (concat org-directory "/notes.org")
        org-agenda-files (list org-directory)
        org-log-done 'time
        org-log-into-drawer t
        org-startup-indented t
        org-startup-folded 'content
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-use-sub-superscripts '{}
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-src-preserve-indentation t
        org-confirm-babel-evaluate nil
        org-export-with-smart-quotes t
        org-export-with-toc t
        org-export-headline-levels 4))

;; Org babel - code execution in org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (shell . t)
   (C . t)
   (java . t)
   (js . t)
   (css . t)
   (sql . t)
   (dot . t)
   (plantuml . t)))

;; Org modern for better appearance
(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)))

;; Org bullets for better bullet points
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Org roam for note-taking and knowledge management
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

;; Org download for image handling
(use-package org-download
  :after org
  :config
  (setq org-download-method 'directory
        org-download-image-dir "images"
        org-download-heading-lvl nil))

;; Org present for presentations
(use-package org-present
  :commands org-present)

;; Org export backends
(use-package ox-gfm
  :after org)

(use-package ox-pandoc
  :after org)

(use-package htmlize
  :after org)

;; Org tree slide for presentations
(use-package org-tree-slide
  :commands org-tree-slide-mode
  :config
  (setq org-tree-slide-activate-message "Presentation started!"
        org-tree-slide-deactivate-message "Presentation ended!"
        org-tree-slide-header t
        org-tree-slide-slide-in-effect t))

;;; Markdown Mode
(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown")
  :config
  (setq markdown-fontify-code-blocks-natively t
        markdown-hide-markup nil
        markdown-enable-math t
        markdown-hide-urls nil
        markdown-gfm-use-electric-backquote nil))

;; Markdown TOC generation
(use-package markdown-toc
  :after markdown-mode)

;; Grip mode for live GitHub-flavored Markdown preview
(use-package grip-mode
  :hook ((markdown-mode . grip-mode)
         (org-mode . grip-mode))
  :config
  (setq grip-preview-use-webkit t))

;; Flyspell for spell checking
(use-package flyspell
  :ensure nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  (setq ispell-program-name "aspell"
        ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))

;; Flyspell correct for easy corrections
(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-;" . flyspell-correct-wrapper)))

;; Writegood mode for better writing
(use-package writegood-mode
  :hook ((text-mode . writegood-mode)
         (org-mode . writegood-mode)
         (markdown-mode . writegood-mode)))

;; Olivetti for distraction-free writing
(use-package olivetti
  :commands olivetti-mode
  :config
  (setq olivetti-body-width 100))

;; LaTeX support
(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t))

;; AsciiDoc mode
(use-package adoc-mode
  :mode "\\.adoc\\'")

;; reStructuredText mode
(use-package rst
  :ensure nil
  :mode ("\\.rst\\'" . rst-mode))

(provide 'writing-config)
;;; writing-config.el ends here
