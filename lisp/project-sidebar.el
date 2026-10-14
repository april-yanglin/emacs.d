;;; project-sidebar.el --- Recent projects & project tree sidebar -*- lexical-binding: t; -*-

;;; Commentary:
;; A VS Code style sidebar built on projectile + treemacs:
;;
;;   +-------------------+------------------------+
;;   | treemacs          |                        |
;;   | (current project  |                        |
;;   |  file tree)       |      editing area      |
;;   +-------------------+                        |
;;   | RECENT PROJECTS   |                        |
;;   | > emacs.d         |                        |
;;   |   my-service      |                        |
;;   +-------------------+------------------------+
;;
;; - The tree only shows the project of the current buffer and follows it
;;   when you move between projects (`treemacs-project-follow-mode').
;; - The recent projects panel lists projectile's known projects in
;;   most-recently-used order; RET switches to a project.
;; - `my/project-open-recent' is a minibuffer picker over the same list.

;;; Code:

(require 'subr-x)
(require 'seq)

(use-package hydra :demand t)
(eval-when-compile (require 'hydra nil t))

(declare-function projectile-project-root "projectile")
(declare-function projectile-project-name "projectile")
(declare-function projectile-project-buffers "projectile")
(declare-function projectile-switch-project-by-name "projectile")
(declare-function projectile-remove-known-project "projectile")
(declare-function projectile-add-known-project "projectile")
(declare-function projectile-known-projects "projectile")
(declare-function treemacs "treemacs")
(declare-function treemacs-current-visibility "treemacs")
(declare-function treemacs-get-local-window "treemacs")
(declare-function treemacs-select-window "treemacs")
(declare-function treemacs-find-file "treemacs")
(declare-function evil-set-initial-state "evil")
(declare-function evil-define-key* "evil")
(defvar projectile-known-projects)
(defvar treemacs-position)

(defgroup my-project-sidebar nil
  "Recent projects and project tree sidebar."
  :group 'convenience)

(defcustom my/recent-projects-max 15
  "Maximum number of projects shown in the recent projects panel."
  :type 'integer)

(defcustom my/recent-projects-panel-height 0.3
  "Height of the recent projects panel, as a fraction of the frame."
  :type 'number)

(defconst my/recent-projects-buffer-name "*Recent Projects*")

;;;; Helpers

(defun my/project--main-window ()
  "Return the most recently used window that is not part of the sidebar."
  (or (seq-find (lambda (w)
                  (not (or (window-parameter w 'window-side)
                           (window-dedicated-p w))))
                (cons (get-mru-window nil nil t) (window-list nil 'nomini)))
      (selected-window)))

(defun my/project--current-root ()
  "Return the projectile root of the buffer in the main window, or nil."
  (when (featurep 'projectile)
    (with-current-buffer (window-buffer (my/project--main-window))
      (projectile-project-root))))

(defun my/recent-projects ()
  "Return known projects in most-recently-used order, skipping missing dirs."
  (require 'projectile)
  (seq-filter (lambda (dir)
                (or (file-remote-p dir) (file-directory-p dir)))
              ;; The function loads the list from disk on first use; the
              ;; variable stays nil until then.
              (if (fboundp 'projectile-known-projects)
                  (projectile-known-projects)
                projectile-known-projects)))

(defun my/project--switch (root)
  "Switch to project ROOT from the main editing window."
  (select-window (my/project--main-window))
  ;; Projectile only bumps MRU order on `find-file' of a new buffer, so do it
  ;; here too: switching to a project counts as using it.
  (projectile-add-known-project root)
  (projectile-switch-project-by-name root))

;;;; Minibuffer picker

(defun my/project-open-recent ()
  "Pick a recent project (most recently used first) and switch to it."
  (interactive)
  (let* ((projects (mapcar #'abbreviate-file-name (my/recent-projects)))
         (current (when-let ((root (my/project--current-root)))
                    (abbreviate-file-name root)))
         (width (apply #'max 10 (mapcar (lambda (p) (length (projectile-project-name p)))
                                        projects)))
         (annotate
          (lambda (dir)
            (let ((nbufs (length (ignore-errors
                                   (projectile-project-buffers (expand-file-name dir))))))
              (concat (propertize " " 'display `(space :align-to ,(+ 4 (length dir))))
                      (propertize (string-pad (projectile-project-name dir) width)
                                  'face 'font-lock-keyword-face)
                      (when (> nbufs 0)
                        (propertize (format "  %d buffer%s" nbufs (if (= nbufs 1) "" "s"))
                                    'face 'completions-annotations))
                      (when (equal dir current)
                        (propertize "  (current)" 'face 'success))))))
         (table (lambda (str pred action)
                  (if (eq action 'metadata)
                      `(metadata (category . my-project)
                                 (annotation-function . ,annotate)
                                 (display-sort-function . identity)
                                 (cycle-sort-function . identity))
                    (complete-with-action action projects str pred)))))
    (unless projects
      (user-error "No known projects yet; open a file inside a project first"))
    (my/project--switch
     (expand-file-name (completing-read "Recent project: " table nil t)))))

;;;; Recent projects panel

(defvar my/recent-projects-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map special-mode-map)
    (define-key map (kbd "RET") #'my/recent-projects-open-at-point)
    (define-key map (kbd "o") #'my/recent-projects-open-at-point)
    (define-key map (kbd "d") #'my/recent-projects-remove-at-point)
    (define-key map (kbd "a") #'my/recent-projects-add)
    (define-key map (kbd "g") #'my/recent-projects-refresh)
    (define-key map (kbd "n") #'next-line)
    (define-key map (kbd "p") #'previous-line)
    (define-key map (kbd "q") #'my/project-sidebar-close)
    map)
  "Keymap for `my/recent-projects-mode'.")

(define-derived-mode my/recent-projects-mode special-mode "Projects"
  "Major mode for the recent projects sidebar panel.
\\{my/recent-projects-mode-map}"
  (setq-local truncate-lines t
              cursor-type nil
              mode-line-format nil)
  (hl-line-mode 1))

(defun my/recent-projects--root-at-point ()
  "Return the project root on the current line, or signal an error."
  (or (get-text-property (line-beginning-position) 'my-project-root)
      (user-error "No project on this line")))

(defun my/recent-projects-open-at-point ()
  "Switch to the project on the current line."
  (interactive)
  (my/project--switch (my/recent-projects--root-at-point)))

(defun my/recent-projects-remove-at-point ()
  "Remove the project on the current line from the known projects."
  (interactive)
  (let ((root (my/recent-projects--root-at-point)))
    (when (y-or-n-p (format "Forget project %s? " (abbreviate-file-name root)))
      (projectile-remove-known-project root)
      (my/recent-projects-refresh))))

(defun my/recent-projects-add (dir)
  "Add DIR to the known projects."
  (interactive (list (read-directory-name "Add project: ")))
  (projectile-add-known-project (file-name-as-directory (expand-file-name dir)))
  (my/recent-projects-refresh))

(defvar my/recent-projects--rendered-root nil
  "Current project root at the time the panel was last rendered.")

(defun my/recent-projects-refresh (&rest _)
  "Redraw the recent projects panel, keeping point on the same project."
  (interactive)
  (when-let ((buf (get-buffer my/recent-projects-buffer-name)))
    (with-current-buffer buf
      (let* ((inhibit-read-only t)
             (current (my/project--current-root))
             (keep (get-text-property (line-beginning-position) 'my-project-root))
             (projects (seq-take (my/recent-projects) my/recent-projects-max))
             (width (apply #'max 10 (mapcar (lambda (p) (length (projectile-project-name p)))
                                            projects))))
        (setq my/recent-projects--rendered-root current)
        (erase-buffer)
        (insert (propertize " RECENT PROJECTS\n" 'face '(:inherit bold :height 0.9)))
        (if (null projects)
            (insert (propertize "  (none yet)\n" 'face 'shadow))
          (dolist (root projects)
            (let ((here (and current (file-equal-p root current)))
                  (start (point)))
              (insert (if here (propertize " ● " 'face 'success) "   ")
                      (propertize (string-pad (projectile-project-name root) width)
                                  'face (if here 'bold 'font-lock-keyword-face))
                      "  "
                      (propertize (abbreviate-file-name root) 'face 'shadow)
                      "\n")
              (add-text-properties start (point)
                                   `(my-project-root ,root
                                     mouse-face highlight
                                     help-echo ,(format "mouse-1/RET: switch to %s" root))))))
        (goto-char (point-min))
        (forward-line 1)
        (when keep
          (when-let ((pos (text-property-any (point-min) (point-max) 'my-project-root keep)))
            (goto-char pos)))
        (when-let ((win (get-buffer-window buf)))
          (set-window-point win (point)))))))

(defun my/recent-projects--maybe-refresh (&rest _)
  "Refresh the panel if it is visible and the current project changed."
  (when (and (get-buffer-window my/recent-projects-buffer-name)
             (not (equal (my/project--current-root) my/recent-projects--rendered-root)))
    (my/recent-projects-refresh)))

(defun my/recent-projects--mouse-open (event)
  "Switch to the project clicked with EVENT."
  (interactive "e")
  (mouse-set-point event)
  (my/recent-projects-open-at-point))

(define-key my/recent-projects-mode-map [mouse-1] #'my/recent-projects--mouse-open)

(defun my/recent-projects--buffer ()
  "Return the recent projects buffer, creating and rendering it if needed."
  (let ((buf (get-buffer-create my/recent-projects-buffer-name)))
    (with-current-buffer buf
      (unless (derived-mode-p 'my/recent-projects-mode)
        (my/recent-projects-mode)))
    (my/recent-projects-refresh)
    buf))

(defun my/recent-projects--display (tree-window)
  "Show the recent projects panel below TREE-WINDOW (or on the left)."
  (let ((buf (my/recent-projects--buffer)))
    (or (get-buffer-window buf)
        (if (and tree-window (not (window-parameter tree-window 'window-side)))
            ;; Treemacs is a normal window: split it.
            (let ((win (split-window tree-window
                                     (- (round (* my/recent-projects-panel-height
                                                  (frame-height))))
                                     'below)))
              (set-window-buffer win buf)
              (set-window-dedicated-p win t)
              win)
          ;; Treemacs (or nothing) lives in a side window: stack below it.
          (display-buffer-in-side-window
           buf
           `((side . ,(if tree-window
                          (window-parameter tree-window 'window-side)
                        'left))
             (slot . ,(1+ (or (and tree-window
                                   (window-parameter tree-window 'window-slot))
                              0)))
             (window-height . ,my/recent-projects-panel-height)
             (dedicated . t)
             (window-parameters . ((no-delete-other-windows . t)
                                   (no-other-window . t)))))))))

;;;###autoload
(defun my/recent-projects-panel ()
  "Show only the recent projects panel and select it."
  (interactive)
  (select-window (my/recent-projects--display
                  (and (featurep 'treemacs) (treemacs-get-local-window)))))

;;;; Sidebar (tree + recent projects)

(defun my/project-sidebar-visible-p ()
  "Return non-nil if any part of the project sidebar is visible."
  (or (get-buffer-window my/recent-projects-buffer-name)
      (and (featurep 'treemacs)
           (eq (treemacs-current-visibility) 'visible))))

(defun my/project-sidebar-close ()
  "Close the project tree and the recent projects panel."
  (interactive)
  (when-let ((win (get-buffer-window my/recent-projects-buffer-name)))
    (delete-window win))
  (when (featurep 'treemacs)
    (when-let ((win (treemacs-get-local-window)))
      (delete-window win))))

(defun my/project-sidebar-open ()
  "Open the project tree for the current project plus the recent projects panel."
  (interactive)
  (require 'treemacs)
  (require 'treemacs-projectile nil t)
  (select-window (my/project--main-window))
  (let ((root (my/project--current-root)))
    (unless (eq (treemacs-current-visibility) 'visible)
      (cond
       ((and root (fboundp 'treemacs-add-and-display-current-project-exclusively))
        (treemacs-add-and-display-current-project-exclusively))
       ((and root (fboundp 'treemacs-display-current-project-exclusively))
        (treemacs-display-current-project-exclusively))
       (t (treemacs))))
    (my/recent-projects--display (treemacs-get-local-window))
    (treemacs-select-window)))

(defun my/project-sidebar-toggle ()
  "Toggle the project sidebar (file tree + recent projects)."
  (interactive)
  (if (my/project-sidebar-visible-p)
      (my/project-sidebar-close)
    (my/project-sidebar-open)))

(defun my/project-sidebar-reveal-file ()
  "Open the sidebar if needed and reveal the current file in the tree."
  (interactive)
  (let ((file buffer-file-name))
    (unless (my/project-sidebar-visible-p)
      (my/project-sidebar-open))
    (when file
      (select-window (my/project--main-window))
      ;; Re-target the tree in case follow mode hasn't caught up yet.
      (when (and (my/project--current-root)
                 (fboundp 'treemacs-add-and-display-current-project-exclusively))
        (treemacs-add-and-display-current-project-exclusively)
        (select-window (my/project--main-window)))
      (treemacs-find-file))))

;;;; Hydra menu (SPC p)

(defhydra my/hydra-project (:exit t :hint nil :foreign-keys warn)
  ("p" projectile-switch-project "switch project" :column "Project")
  ("o" my/project-open-recent "recent projects")
  ("f" projectile-find-file "find file")
  ("r" projectile-recentf "recent file")
  ("b" projectile-switch-to-buffer "switch buffer")
  ("k" projectile-kill-buffers "kill buffers")
  ("s" projectile-ripgrep "search" :column "Search/Build")
  ("R" projectile-replace "replace")
  ("c" projectile-compile-project "compile")
  ("T" projectile-test-project "test")
  ("I" projectile-invalidate-cache "invalidate cache")
  ("t" my/project-sidebar-toggle "toggle sidebar" :column "Tree")
  ("e" my/project-sidebar-reveal-file "reveal file")
  ("l" my/recent-projects-panel "recent panel")
  ("n" treemacs "treemacs")
  ("q" nil "quit"))

;;;; Wiring

(with-eval-after-load 'projectile
  (add-hook 'projectile-after-switch-project-hook #'my/recent-projects-refresh)
  ;; Run after projectile's own find-file hook has bumped the MRU order.
  (add-hook 'find-file-hook #'my/recent-projects-refresh 90))

(add-hook 'window-buffer-change-functions #'my/recent-projects--maybe-refresh)
(add-hook 'window-selection-change-functions #'my/recent-projects--maybe-refresh)

(with-eval-after-load 'evil
  (evil-set-initial-state 'my/recent-projects-mode 'normal)
  (evil-define-key* 'normal my/recent-projects-mode-map
    (kbd "RET") #'my/recent-projects-open-at-point
    "o" #'my/recent-projects-open-at-point
    "d" #'my/recent-projects-remove-at-point
    "a" #'my/recent-projects-add
    "gr" #'my/recent-projects-refresh
    "q" #'my/project-sidebar-close
    [mouse-1] #'my/recent-projects--mouse-open))

(global-set-key (kbd "<f8>") #'my/project-sidebar-toggle)

(provide 'project-sidebar)
;;; project-sidebar.el ends here
