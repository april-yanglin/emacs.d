;;; lang-cuda.el --- CUDA configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; CUDA development configuration for GPU programming

;;; Code:

;; CUDA mode
(use-package cuda-mode
  :mode (("\\.cu\\'" . cuda-mode)
         ("\\.cuh\\'" . cuda-mode))
  :config
  (setq cuda-mode-hook
        (lambda ()
          (setq c-basic-offset 4)
          (setq indent-tabs-mode nil))))

;; Add LSP support for CUDA files (uses clangd with CUDA support)
(add-hook 'cuda-mode-hook #'lsp-deferred)

;; CUDA compilation commands
(defun cuda-compile-current-file ()
  "Compile current CUDA file using nvcc."
  (interactive)
  (let ((file (buffer-file-name)))
    (compile (format "nvcc -o %s.out %s"
                     (file-name-sans-extension file)
                     file))))

(defun cuda-compile-and-run ()
  "Compile and run current CUDA file."
  (interactive)
  (let* ((file (buffer-file-name))
         (output (file-name-sans-extension file)))
    (compile (format "nvcc -o %s.out %s && ./%s.out"
                     output file output))))

;; Keybindings for CUDA mode
(with-eval-after-load 'cuda-mode
  (define-key cuda-mode-map (kbd "C-c C-c") 'cuda-compile-current-file)
  (define-key cuda-mode-map (kbd "C-c C-r") 'cuda-compile-and-run))

;; Syntax highlighting improvements for CUDA keywords
(font-lock-add-keywords 'cuda-mode
  '(("\\<\\(threadIdx\\|blockIdx\\|blockDim\\|gridDim\\)\\>" . font-lock-builtin-face)
    ("\\<\\(__global__\\|__device__\\|__host__\\|__shared__\\|__constant__\\)\\>" . font-lock-keyword-face)
    ("\\<\\(__syncthreads\\|__threadfence\\|__threadfence_block\\|__threadfence_system\\)\\>" . font-lock-function-name-face)))

;; Flycheck support for CUDA
(with-eval-after-load 'flycheck
  (flycheck-define-checker cuda-nvcc
    "A CUDA checker using nvcc."
    :command ("nvcc"
              "-std=c++14"
              "--compiler-options" "-Wall"
              "-x" "cu"
              "--output-file" "/dev/null"
              source-inplace)
    :error-patterns
    ((error line-start
            (file-name) "(" line "): error: " (message)
            line-end)
     (warning line-start
              (file-name) "(" line "): warning: " (message)
              line-end))
    :modes cuda-mode)

  (add-to-list 'flycheck-checkers 'cuda-nvcc))

(provide 'lang-cuda)
;;; lang-cuda.el ends here
