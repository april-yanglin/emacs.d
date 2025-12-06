;;; lang-frontend.el --- Frontend development configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Frontend development: HTML, CSS, JavaScript, TypeScript, React, Vue, etc.

;;; Code:

;; Web mode for HTML/CSS/JS/JSX/TSX
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.jsx?\\'" . web-mode)
         ("\\.tsx?\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.json\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t))

;; JavaScript mode
(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node"
  :hook (js2-mode . lsp-deferred)
  :config
  (setq js2-basic-offset 2
        js2-highlight-level 3
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil))

;; JavaScript refactoring
(use-package js2-refactor
  :hook (js2-mode . js2-refactor-mode)
  :config
  (js2r-add-keybindings-with-prefix "C-c C-r"))

;; TypeScript mode
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; TSX support
(use-package tsx-mode
  :mode "\\.tsx\\'"
  :hook (tsx-mode . lsp-deferred))

;; JSON mode
(use-package json-mode
  :mode "\\.json\\'"
  :config
  (setq json-reformat:indent-width 2))

;; YAML mode
(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

;; TOML mode
(use-package toml-mode
  :mode "\\.toml\\'")

;; Vue mode
(use-package vue-mode
  :mode "\\.vue\\'"
  :hook (vue-mode . lsp-deferred)
  :config
  (setq vue-html-extra-indent 2))

;; Emmet for HTML/CSS
(use-package emmet-mode
  :hook ((web-mode . emmet-mode)
         (css-mode . emmet-mode)
         (html-mode . emmet-mode)
         (sgml-mode . emmet-mode))
  :config
  (setq emmet-move-cursor-between-quotes t))

;; CSS mode enhancements
(use-package css-mode
  :ensure nil
  :mode "\\.css\\'"
  :config
  (setq css-indent-offset 2))

;; SCSS mode
(use-package scss-mode
  :mode "\\.scss\\'"
  :config
  (setq scss-compile-at-save nil))

;; SASS mode
(use-package sass-mode
  :mode "\\.sass\\'")

;; LESS mode
(use-package less-css-mode
  :mode "\\.less\\'")

;; Styled components
(use-package styled-components-mode
  :hook (styled-components-mode . lsp-deferred))

;; Prettier for code formatting
(use-package prettier-js
  :hook ((js2-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode)
         (web-mode . prettier-js-mode)
         (json-mode . prettier-js-mode)))

;; ESLint integration
(use-package flycheck-eslint
  :after flycheck
  :hook ((js2-mode . (lambda ()
                       (when (executable-find "eslint")
                         (flycheck-select-checker 'javascript-eslint))))))

;; npm mode for package.json integration
(use-package npm-mode
  :hook ((json-mode . (lambda ()
                        (when (string-match-p "package\\.json$" (buffer-file-name))
                          (npm-mode))))))

;; Add node_modules/.bin to PATH
(use-package add-node-modules-path
  :hook ((js2-mode . add-node-modules-path)
         (typescript-mode . add-node-modules-path)
         (web-mode . add-node-modules-path)))

;; REST client for API testing
(use-package restclient
  :mode ("\\.http\\'" . restclient-mode))

(use-package company-restclient
  :after (company restclient)
  :config
  (add-to-list 'company-backends 'company-restclient))

;; GraphQL mode
(use-package graphql-mode
  :mode "\\.graphql\\'")

;; MDX mode (Markdown + JSX)
(use-package markdown-mode
  :mode (("\\.mdx\\'" . markdown-mode)))

;; Svelte mode
(use-package svelte-mode
  :mode "\\.svelte\\'")

(provide 'lang-frontend)
;;; lang-frontend.el ends here
