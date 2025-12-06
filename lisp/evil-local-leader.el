;;; evil-local-leader.el --- Major mode specific keybindings -*- lexical-binding: t; -*-

;;; Commentary:
;; Local leader (comma) keybindings for major mode specific commands

;;; Code:

(require 'general)

;; Python mode local bindings
(general-create-definer python-local-leader
  :states '(normal visual)
  :keymaps 'python-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(python-local-leader
  "" '(:ignore t :which-key "python")
  "c" '(:ignore t :which-key "conda/venv")
  "ca" '(conda-env-activate :which-key "activate conda env")
  "cd" '(conda-env-deactivate :which-key "deactivate conda env")
  "cl" '(conda-env-list :which-key "list conda envs")
  "cv" '(pyvenv-workon :which-key "workon virtualenv")
  "cp" '(poetry-venv-workon :which-key "poetry venv")

  "t" '(:ignore t :which-key "test")
  "tt" '(python-pytest-dispatch :which-key "pytest")
  "tf" '(python-pytest-file :which-key "test file")
  "ta" '(python-pytest :which-key "test all")

  "r" '(:ignore t :which-key "refactor/run")
  "ri" '(py-isort-buffer :which-key "isort")
  "rb" '(python-black-buffer :which-key "black format")
  "rr" '(python-shell-send-region :which-key "send region")
  "rf" '(python-shell-send-defun :which-key "send function")
  "re" '(python-shell-send-buffer :which-key "send buffer")

  "s" '(:ignore t :which-key "shell")
  "ss" '(run-python :which-key "start python shell")
  "sb" '(python-shell-send-buffer :which-key "send buffer")
  "sr" '(python-shell-send-region :which-key "send region")

  "d" '(:ignore t :which-key "debug")
  "db" '(python-add-breakpoint :which-key "add breakpoint")

  "n" '(:ignore t :which-key "notebook")
  "nn" '(ein:notebooklist-open :which-key "open notebook list")
  "nl" '(ein:notebooklist-login :which-key "login")

  "i" '(:ignore t :which-key "imports")
  "is" '(py-isort-buffer :which-key "sort imports"))

;; Go mode local bindings
(general-create-definer go-local-leader
  :states '(normal visual)
  :keymaps 'go-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(go-local-leader
  "" '(:ignore t :which-key "go")
  "t" '(:ignore t :which-key "test")
  "tt" '(go-test-current-test :which-key "test current")
  "tf" '(go-test-current-file :which-key "test file")
  "tp" '(go-test-current-project :which-key "test project")
  "tb" '(go-test-current-benchmark :which-key "benchmark")

  "r" '(:ignore t :which-key "refactor")
  "rn" '(lsp-rename :which-key "rename")
  "ri" '(go-import-add :which-key "add import")
  "rr" '(go-remove-unused-imports :which-key "remove unused imports")

  "g" '(:ignore t :which-key "goto")
  "gi" '(go-goto-imports :which-key "goto imports")
  "gd" '(go-goto-docstring :which-key "goto docstring")

  "d" '(:ignore t :which-key "doc")
  "dd" '(godoc-at-point :which-key "doc at point")

  "x" '(:ignore t :which-key "execute")
  "xr" '(go-run :which-key "run")
  "xb" '(go-build :which-key "build")

  "a" '(:ignore t :which-key "tags")
  "aa" '(go-tag-add :which-key "add tags")
  "ar" '(go-tag-remove :which-key "remove tags"))

;; Java mode local bindings
(general-create-definer java-local-leader
  :states '(normal visual)
  :keymaps 'java-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(java-local-leader
  "" '(:ignore t :which-key "java")
  "t" '(:ignore t :which-key "test")
  "tt" '(dap-java-run-test-method :which-key "test method")
  "tc" '(dap-java-run-test-class :which-key "test class")

  "r" '(:ignore t :which-key "refactor")
  "rn" '(lsp-java-rename :which-key "rename")
  "ro" '(lsp-java-organize-imports :which-key "organize imports")
  "re" '(lsp-java-extract-to-constant :which-key "extract constant")
  "rm" '(lsp-java-extract-method :which-key "extract method")

  "d" '(:ignore t :which-key "debug")
  "dd" '(dap-debug :which-key "debug")
  "db" '(dap-breakpoint-toggle :which-key "toggle breakpoint")

  "p" '(:ignore t :which-key "project")
  "pb" '(lsp-java-build-project :which-key "build project")
  "pu" '(lsp-java-update-project-configuration :which-key "update config")

  "m" '(:ignore t :which-key "maven")
  "mc" '(mvn-clean :which-key "clean")
  "mi" '(mvn-compile :which-key "compile")
  "mt" '(mvn-test :which-key "test"))

;; C/C++ mode local bindings
(general-create-definer cpp-local-leader
  :states '(normal visual)
  :keymaps '(c-mode-map c++-mode-map)
  :prefix ","
  :non-normal-prefix "M-,")

(cpp-local-leader
  "" '(:ignore t :which-key "c/c++")
  "c" '(:ignore t :which-key "compile")
  "cc" '(compile :which-key "compile")
  "cr" '(recompile :which-key "recompile")
  "cm" '(cmake-ide-compile :which-key "cmake compile")

  "f" '(:ignore t :which-key "format")
  "ff" '(clang-format-buffer :which-key "format buffer")
  "fr" '(clang-format-region :which-key "format region")

  "d" '(:ignore t :which-key "debug/disassemble")
  "dd" '(gdb :which-key "gdb")
  "da" '(disaster :which-key "disassemble")

  "r" '(:ignore t :which-key "refactor")
  "rn" '(lsp-rename :which-key "rename"))

;; CUDA mode local bindings
(general-create-definer cuda-local-leader
  :states '(normal visual)
  :keymaps 'cuda-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(cuda-local-leader
  "" '(:ignore t :which-key "cuda")
  "c" '(:ignore t :which-key "compile")
  "cc" '(cuda-compile-current-file :which-key "compile")
  "cr" '(cuda-compile-and-run :which-key "compile & run"))

;; JavaScript/TypeScript local bindings
(general-create-definer js-local-leader
  :states '(normal visual)
  :keymaps '(js2-mode-map typescript-mode-map)
  :prefix ","
  :non-normal-prefix "M-,")

(js-local-leader
  "" '(:ignore t :which-key "js/ts")
  "r" '(:ignore t :which-key "refactor")
  "rr" '(js2r-rename-var :which-key "rename variable")
  "re" '(js2r-extract-function :which-key "extract function")
  "ri" '(js2r-inline-var :which-key "inline variable")

  "f" '(:ignore t :which-key "format")
  "ff" '(prettier-js :which-key "prettier format")

  "t" '(:ignore t :which-key "test")
  "tt" '((lambda () (interactive) (compile "npm test")) :which-key "run tests")

  "n" '(:ignore t :which-key "npm")
  "ni" '((lambda () (interactive) (compile "npm install")) :which-key "install")
  "nr" '(npm-mode-npm-run :which-key "run script")
  "ns" '((lambda () (interactive) (compile "npm start")) :which-key "start")
  "nb" '((lambda () (interactive) (compile "npm run build")) :which-key "build"))

;; Org mode local bindings
(general-create-definer org-local-leader
  :states '(normal visual)
  :keymaps 'org-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(org-local-leader
  "" '(:ignore t :which-key "org")
  "a" '(org-archive-subtree :which-key "archive")
  "b" '(org-tree-to-indirect-buffer :which-key "tree to buffer")

  "c" '(:ignore t :which-key "clock")
  "ci" '(org-clock-in :which-key "clock in")
  "co" '(org-clock-out :which-key "clock out")
  "cr" '(org-clock-report :which-key "clock report")

  "d" '(:ignore t :which-key "date/deadline")
  "dd" '(org-deadline :which-key "deadline")
  "ds" '(org-schedule :which-key "schedule")
  "dt" '(org-time-stamp :which-key "timestamp")

  "e" '(:ignore t :which-key "export")
  "ee" '(org-export-dispatch :which-key "export")
  "eh" '(org-html-export-to-html :which-key "export to html")
  "em" '(org-md-export-to-markdown :which-key "export to markdown")
  "ep" '(org-pandoc-export-to-pdf :which-key "export to pdf")

  "i" '(:ignore t :which-key "insert")
  "il" '(org-insert-link :which-key "link")
  "ih" '(org-insert-heading :which-key "heading")
  "is" '(org-insert-subheading :which-key "subheading")

  "l" '(:ignore t :which-key "links")
  "ll" '(org-insert-link :which-key "insert link")
  "ls" '(org-store-link :which-key "store link")

  "p" '(:ignore t :which-key "properties")
  "ps" '(org-set-property :which-key "set property")
  "pd" '(org-delete-property :which-key "delete property")

  "t" '(:ignore t :which-key "todos")
  "tt" '(org-todo :which-key "todo")
  "tT" '(org-todo-list :which-key "todo list")
  "ts" '(org-schedule :which-key "schedule")

  "s" '(:ignore t :which-key "subtree")
  "sn" '(org-narrow-to-subtree :which-key "narrow")
  "sw" '(widen :which-key "widen")
  "sr" '(org-refile :which-key "refile")
  "ss" '(org-sort :which-key "sort")

  "x" '(:ignore t :which-key "babel/execute")
  "xx" '(org-babel-execute-src-block :which-key "execute block")
  "xb" '(org-babel-execute-buffer :which-key "execute buffer")
  "xt" '(org-babel-tangle :which-key "tangle"))

;; Markdown mode local bindings
(general-create-definer markdown-local-leader
  :states '(normal visual)
  :keymaps 'markdown-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(markdown-local-leader
  "" '(:ignore t :which-key "markdown")
  "p" '(markdown-preview :which-key "preview")
  "P" '(grip-mode :which-key "grip preview")

  "i" '(:ignore t :which-key "insert")
  "il" '(markdown-insert-link :which-key "link")
  "ii" '(markdown-insert-image :which-key "image")
  "ic" '(markdown-insert-code :which-key "code")
  "ib" '(markdown-insert-bold :which-key "bold")
  "ii" '(markdown-insert-italic :which-key "italic")

  "t" '(:ignore t :which-key "table/toc")
  "tt" '(markdown-toc-generate-toc :which-key "generate toc")
  "tr" '(markdown-toc-refresh-toc :which-key "refresh toc")
  "td" '(markdown-toc-delete-toc :which-key "delete toc")

  "e" '(:ignore t :which-key "export")
  "ee" '(markdown-export :which-key "export")
  "eh" '(markdown-export-and-preview :which-key "export & preview"))

;; Docker mode local bindings
(general-create-definer docker-local-leader
  :states '(normal visual)
  :keymaps 'dockerfile-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(docker-local-leader
  "" '(:ignore t :which-key "docker")
  "b" '(docker-build-current-file :which-key "build")
  "c" '(docker :which-key "docker commands"))

;; Docker Compose local bindings
(general-create-definer docker-compose-local-leader
  :states '(normal visual)
  :keymaps 'docker-compose-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(docker-compose-local-leader
  "" '(:ignore t :which-key "docker-compose")
  "u" '(docker-compose-up :which-key "up")
  "d" '(docker-compose-down :which-key "down")
  "r" '(docker-compose-restart :which-key "restart"))

;; SQL mode local bindings
(general-create-definer sql-local-leader
  :states '(normal visual)
  :keymaps 'sql-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(sql-local-leader
  "" '(:ignore t :which-key "sql")
  "s" '(:ignore t :which-key "send")
  "sb" '(sql-send-buffer :which-key "send buffer")
  "sr" '(sql-send-region :which-key "send region")
  "sp" '(sql-send-paragraph :which-key "send paragraph")

  "c" '(sql-connect :which-key "connect")
  "f" '(sqlformat :which-key "format"))

;; Web mode local bindings
(general-create-definer web-local-leader
  :states '(normal visual)
  :keymaps 'web-mode-map
  :prefix ","
  :non-normal-prefix "M-,")

(web-local-leader
  "" '(:ignore t :which-key "web")
  "e" '(emmet-expand-line :which-key "emmet expand")
  "f" '(prettier-js :which-key "prettier format"))

;; Magit mode bindings (special case - already in magit)
(with-eval-after-load 'magit
  (general-define-key
   :states 'normal
   :keymaps 'magit-mode-map
   "q" 'magit-mode-bury-buffer
   "TAB" 'magit-section-toggle
   "RET" 'magit-visit-thing))

(provide 'evil-local-leader)
;;; evil-local-leader.el ends here
