;;; base-config.el --- Base configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Basic Emacs configuration and quality of life improvements

;;; Code:

;; UTF-8 encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Better defaults
(setq-default
 indent-tabs-mode nil           ; Use spaces instead of tabs
 tab-width 4                     ; Default tab width
 fill-column 80                  ; Default line width
 require-final-newline t         ; Always end files with newline
 truncate-lines nil              ; Wrap lines
 word-wrap t)                    ; Wrap at word boundaries

;; General settings
(setq
 auto-save-default t
 create-lockfiles nil
 make-backup-files t
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 vc-follow-symlinks t
 echo-keystrokes 0.1
 ring-bell-function 'ignore
 sentence-end-double-space nil
 confirm-kill-processes nil)

;; Enable useful features
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode 1))
(when (fboundp 'show-paren-mode)
  (show-paren-mode 1))
(when (fboundp 'global-auto-revert-mode)
  (global-auto-revert-mode 1))
(when (fboundp 'delete-selection-mode)
  (delete-selection-mode 1))
(when (fboundp 'column-number-mode)
  (column-number-mode 1))
(when (fboundp 'size-indication-mode)
  (size-indication-mode 1))
(when (fboundp 'save-place-mode)
  (save-place-mode 1))
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode 1))

;; Recentf - remember recent files
(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-saved-items 500
        recentf-max-menu-items 15
        recentf-auto-cleanup 'never)
  (recentf-mode 1))

;; Better minibuffer completion
(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)))

;; Which-key - show available keybindings
(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

;; Better help
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

(provide 'base-config)
;;; base-config.el ends here
