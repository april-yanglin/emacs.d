;;; lang-cpp.el --- C/C++ configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; C/C++ development configuration with LSP (clangd) and modern C++ support

;;; Code:

;; C/C++ mode configuration
(use-package cc-mode
  :ensure nil
  :mode (("\\.c\\'" . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.cc\\'" . c++-mode)
         ("\\.cxx\\'" . c++-mode)
         ("\\.h\\'" . c++-mode)
         ("\\.hpp\\'" . c++-mode)
         ("\\.hxx\\'" . c++-mode))
  :hook ((c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (c-mode-common . (lambda ()
                           (c-set-style "linux")
                           (setq c-basic-offset 4
                                 tab-width 4
                                 indent-tabs-mode nil))))
  :config
  (setq c-default-style "linux"))

;; Modern C++ font-lock
(use-package modern-cpp-font-lock
  :diminish modern-c++-font-lock-mode
  :hook (c++-mode . modern-c++-font-lock-mode))

;; CMake support
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after cmake-mode
  :hook (cmake-mode . cmake-font-lock-activate))

;; CMake IDE integration
(use-package cmake-ide
  :after projectile
  :config
  (cmake-ide-setup))

;; Clang-format
(use-package clang-format
  :bind (:map c-mode-base-map
              ("C-c f" . clang-format-buffer))
  :config
  (setq clang-format-style "file"))

;; Clang-format on save
(add-hook 'c++-mode-hook
          (lambda ()
            (when (locate-dominating-file "." ".clang-format")
              (add-hook 'before-save-hook 'clang-format-buffer nil 'local))))

;; Google C++ Style
(use-package google-c-style
  :hook ((c-mode . google-set-c-style)
         (c++-mode . google-set-c-style)))

;; Irony mode (alternative C++ completion, uncomment if not using LSP)
;; (use-package irony
;;   :hook ((c-mode . irony-mode)
;;          (c++-mode . irony-mode)
;;          (objc-mode . irony-mode))
;;   :config
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; Note: completion is handled by LSP (clangd) through Corfu/Cape;
;; irony/company-irony are no longer needed.

;; Disaster - see assembly
(use-package disaster
  :commands disaster
  :bind (:map c-mode-base-map
              ("C-c d" . disaster)))

;; GDB integration
(setq gdb-many-windows t
      gdb-show-main t)

;; Makefile support
(use-package make-mode
  :ensure nil
  :mode (("Makefile\\'" . makefile-mode)
         ("\\.mk\\'" . makefile-mode)))

(provide 'lang-cpp)
;;; lang-cpp.el ends here
