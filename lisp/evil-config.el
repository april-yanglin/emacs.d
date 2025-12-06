;;; evil-config.el --- Evil mode configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Evil mode with space as leader key and comma as major-mode leader

;;; Code:

;; Evil mode - Vim emulation
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-want-Y-yank-to-eol t
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo
        evil-search-module 'evil-search
        evil-split-window-below t
        evil-vsplit-window-right t)
  :config
  (evil-mode 1)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Set initial states for certain modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Evil collection - Evil bindings for many modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Evil commentary - easy commenting
(use-package evil-commentary
  :after evil
  :diminish evil-commentary-mode
  :config
  (evil-commentary-mode))

;; Evil surround - surround text objects
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Evil indent textobject
(use-package evil-indent-plus
  :after evil
  :config
  (evil-indent-plus-default-bindings))

;; Evil matchit - jump between matching tags
(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

;; Evil numbers - increment/decrement numbers
(use-package evil-numbers
  :after evil
  :bind (:map evil-normal-state-map
              ("C-c +" . evil-numbers/inc-at-pt)
              ("C-c -" . evil-numbers/dec-at-pt)))

;; Evil exchange - exchange two regions
(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))

;; Evil visualstar - search selected text with *
(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode))

;; General - convenient key binding
(use-package general
  :config
  (general-evil-setup t)

  ;; Global leader key - Space
  (general-create-definer leader-def
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC")

  ;; Local leader key - Comma (for major mode specific bindings)
  (general-create-definer local-leader-def
    :states '(normal visual)
    :keymaps 'override
    :prefix ","
    :non-normal-prefix "M-,")

  ;; Global keybindings with Space leader
  (leader-def
    ;; Basic commands
    "SPC" '(execute-extended-command :which-key "M-x")
    ":" '(eval-expression :which-key "eval")
    ";" '(execute-extended-command :which-key "M-x")
    "u" '(universal-argument :which-key "universal arg")
    "TAB" '(mode-line-other-buffer :which-key "prev buffer")

    ;; Help
    "h" '(:ignore t :which-key "help")
    "hf" '(helpful-callable :which-key "describe function")
    "hv" '(helpful-variable :which-key "describe variable")
    "hk" '(helpful-key :which-key "describe key")
    "hx" '(helpful-command :which-key "describe command")
    "hm" '(describe-mode :which-key "describe mode")
    "hp" '(describe-package :which-key "describe package")

    ;; Files
    "f" '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fr" '(recentf-open-files :which-key "recent files")
    "fR" '(rename-file :which-key "rename file")
    "fs" '(save-buffer :which-key "save file")
    "fS" '(write-file :which-key "save as")
    "fd" '(delete-file :which-key "delete file")
    "fD" '(dired :which-key "dired")
    "fy" '((lambda () (interactive) (kill-new (buffer-file-name))) :which-key "yank path")

    ;; Buffers
    "b" '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")
    "bD" '(kill-buffer :which-key "kill buffer (choose)")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "previous buffer")
    "br" '(revert-buffer :which-key "revert buffer")
    "bR" '(rename-buffer :which-key "rename buffer")
    "bs" '(save-buffer :which-key "save buffer")
    "bS" '(save-some-buffers :which-key "save all buffers")
    "by" '((lambda () (interactive) (kill-new (buffer-name))) :which-key "yank buffer name")

    ;; Windows
    "w" '(:ignore t :which-key "windows")
    "ww" '(other-window :which-key "other window")
    "wd" '(delete-window :which-key "delete window")
    "wD" '(delete-other-windows :which-key "delete other windows")
    "ws" '(split-window-below :which-key "split below")
    "wv" '(split-window-right :which-key "split right")
    "wh" '(evil-window-left :which-key "window left")
    "wj" '(evil-window-down :which-key "window down")
    "wk" '(evil-window-up :which-key "window up")
    "wl" '(evil-window-right :which-key "window right")
    "w=" '(balance-windows :which-key "balance windows")
    "wm" '(delete-other-windows :which-key "maximize window")

    ;; Quit
    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "quit emacs")
    "qQ" '(kill-emacs :which-key "quit without saving")
    "qr" '(restart-emacs :which-key "restart emacs")

    ;; Search
    "s" '(:ignore t :which-key "search")
    "ss" '(consult-line :which-key "search buffer")
    "sS" '(consult-line-multi :which-key "search buffers")
    "sp" '(consult-ripgrep :which-key "search project")
    "si" '(consult-imenu :which-key "search imenu")
    "sI" '(consult-imenu-multi :which-key "search imenu all")
    "so" '(consult-outline :which-key "search outline")
    "sg" '(consult-grep :which-key "grep")
    "sf" '(consult-find :which-key "find file")

    ;; Project (Projectile)
    "p" '(:ignore t :which-key "project")
    "pp" '(projectile-switch-project :which-key "switch project")
    "pf" '(projectile-find-file :which-key "find file")
    "pr" '(projectile-recentf :which-key "recent files")
    "pb" '(projectile-switch-to-buffer :which-key "switch buffer")
    "pk" '(projectile-kill-buffers :which-key "kill buffers")
    "ps" '(projectile-ripgrep :which-key "search project")
    "pc" '(projectile-compile-project :which-key "compile")
    "pt" '(projectile-test-project :which-key "test")
    "pR" '(projectile-replace :which-key "replace")
    "pI" '(projectile-invalidate-cache :which-key "invalidate cache")

    ;; Git (Magit)
    "g" '(:ignore t :which-key "git")
    "gg" '(magit-status :which-key "status")
    "gd" '(magit-diff-unstaged :which-key "diff unstaged")
    "gD" '(magit-diff-staged :which-key "diff staged")
    "gc" '(magit-commit :which-key "commit")
    "gp" '(magit-push :which-key "push")
    "gP" '(magit-pull :which-key "pull")
    "gf" '(magit-fetch :which-key "fetch")
    "gb" '(magit-branch :which-key "branch")
    "gl" '(magit-log :which-key "log")
    "gs" '(magit-stage-file :which-key "stage file")
    "gu" '(magit-unstage-file :which-key "unstage file")
    "gB" '(magit-blame :which-key "blame")

    ;; LSP
    "l" '(:ignore t :which-key "lsp")
    "lr" '(lsp-rename :which-key "rename")
    "la" '(lsp-execute-code-action :which-key "code action")
    "lf" '(lsp-format-buffer :which-key "format")
    "ld" '(lsp-find-definition :which-key "find definition")
    "lD" '(lsp-find-declaration :which-key "find declaration")
    "li" '(lsp-find-implementation :which-key "find implementation")
    "lR" '(lsp-find-references :which-key "find references")
    "lt" '(lsp-find-type-definition :which-key "type definition")
    "ls" '(lsp-describe-session :which-key "describe session")
    "lS" '(lsp-workspace-restart :which-key "restart workspace")
    "le" '(lsp-treemacs-errors-list :which-key "errors list")
    "lh" '(lsp-document-highlight :which-key "highlight")

    ;; Code
    "c" '(:ignore t :which-key "code")
    "cc" '(compile :which-key "compile")
    "cC" '(recompile :which-key "recompile")
    "cf" '(format-all-buffer :which-key "format")
    "cx" '(quickrun :which-key "execute")
    "ce" '(eval-last-sexp :which-key "eval sexp")
    "cE" '(eval-buffer :which-key "eval buffer")
    "cr" '(evilnc-comment-or-uncomment-lines :which-key "comment")

    ;; Errors/Diagnostics
    "e" '(:ignore t :which-key "errors")
    "en" '(flycheck-next-error :which-key "next error")
    "ep" '(flycheck-previous-error :which-key "previous error")
    "el" '(flycheck-list-errors :which-key "list errors")
    "ev" '(flycheck-verify-setup :which-key "verify setup")
    "es" '(flycheck-select-checker :which-key "select checker")

    ;; Toggle
    "t" '(:ignore t :which-key "toggle")
    "tn" '(display-line-numbers-mode :which-key "line numbers")
    "tw" '(whitespace-mode :which-key "whitespace")
    "tt" '(toggle-truncate-lines :which-key "truncate lines")
    "tv" '(visual-line-mode :which-key "visual line mode")
    "tf" '(toggle-frame-fullscreen :which-key "fullscreen")
    "tF" '(flycheck-mode :which-key "flycheck")
    "ts" '(flyspell-mode :which-key "flyspell")

    ;; Open
    "o" '(:ignore t :which-key "open")
    "ot" '(vterm :which-key "terminal")
    "oe" '(eshell :which-key "eshell")
    "od" '(dired :which-key "dired")
    "op" '(treemacs :which-key "treemacs")

    ;; Insert
    "i" '(:ignore t :which-key "insert")
    "is" '(yas-insert-snippet :which-key "snippet")
    "iu" '(insert-char :which-key "unicode")

    ;; Notes/Org
    "n" '(:ignore t :which-key "notes")
    "na" '(org-agenda :which-key "agenda")
    "nc" '(org-capture :which-key "capture")
    "nl" '(org-store-link :which-key "store link")
    "nf" '(org-roam-node-find :which-key "find node")
    "ni" '(org-roam-node-insert :which-key "insert node")
    "nj" '(org-roam-dailies-capture-today :which-key "daily note")
    "nt" '(org-todo-list :which-key "todo list")
    ))

;; Which-key for showing available keybindings
(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3
        which-key-separator " → "
        which-key-prefix-prefix "+"
        which-key-sort-order 'which-key-key-order-alpha
        which-key-max-display-columns 4)
  (which-key-mode 1))

;; Quickrun for quick code execution
(use-package quickrun
  :commands quickrun
  :config
  (setq quickrun-timeout-seconds 60))

;; Restart emacs from within emacs
(use-package restart-emacs
  :commands restart-emacs)

;; Vterm for better terminal emulation
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; Treemacs file explorer
(use-package treemacs
  :commands treemacs
  :config
  (setq treemacs-width 35
        treemacs-follow-mode t
        treemacs-filewatch-mode t))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package lsp-treemacs
  :after (lsp-mode treemacs))

(provide 'evil-config)
;;; evil-config.el ends here
