;;; data-config.el --- Data formats configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration for working with data formats: CSV, Parquet, SQL, etc.

;;; Code:

;; CSV mode
(use-package csv-mode
  :mode "\\.[Cc][Ss][Vv]\\'"
  :config
  (setq csv-separators '("," ";" "|" " "))
  :bind (:map csv-mode-map
              ("C-c C-a" . csv-align-fields)
              ("C-c C-u" . csv-unalign-fields)
              ("C-c C-s" . csv-sort-fields)
              ("C-c C-n" . csv-sort-numeric-fields)
              ("C-c C-k" . csv-kill-fields)
              ("C-c C-y" . csv-yank-fields)))

;; TSV (Tab-separated values)
(add-to-list 'auto-mode-alist '("\\.tsv\\'" . csv-mode))

;; Apache Parquet support (view with external tools)
(defun parquet-view-file ()
  "View Parquet file using parquet-tools or Apache Arrow."
  (interactive)
  (let ((file (buffer-file-name)))
    (if (executable-find "parquet-tools")
        (shell-command (format "parquet-tools cat %s" file))
      (if (executable-find "python3")
          (let ((python-script
                 (format "import pyarrow.parquet as pq; df = pq.read_table('%s').to_pandas(); print(df)" file)))
            (shell-command (format "python3 -c \"%s\"" python-script)))
        (message "Install parquet-tools or pyarrow to view Parquet files")))))

(add-to-list 'auto-mode-alist '("\\.parquet\\'" . fundamental-mode))
(add-hook 'find-file-hook
          (lambda ()
            (when (string-match-p "\\.parquet\\'" (buffer-file-name))
              (local-set-key (kbd "C-c C-v") 'parquet-view-file))))

;; SQL mode
(use-package sql
  :ensure nil
  :mode (("\\.sql\\'" . sql-mode)
         ("\\.ddl\\'" . sql-mode))
  :config
  (setq sql-product 'postgres))

;; SQL indent
(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

;; SQLFormat
(use-package sqlformat
  :commands sqlformat
  :config
  (setq sqlformat-command 'pgformatter))

;; SQLite support
(use-package sqlite-mode
  :ensure nil
  :mode "\\.sqlite\\'")

;; SQL result viewing
(use-package emacsql
  :defer t)

(use-package emacsql-sqlite
  :after emacsql)

;; Clickhouse SQL mode
(use-package clickhouse-mode
  :mode "\\.clickhouse\\'")

;; Protocol Buffers
(use-package protobuf-mode
  :mode "\\.proto\\'")

;; Apache Avro IDL
(use-package avro-mode
  :mode "\\.avdl\\'")

;; XML mode
(use-package nxml-mode
  :ensure nil
  :mode (("\\.xml\\'" . nxml-mode)
         ("\\.xsd\\'" . nxml-mode)
         ("\\.xslt\\'" . nxml-mode)
         ("\\.svg\\'" . nxml-mode))
  :config
  (setq nxml-child-indent 4
        nxml-attribute-indent 4
        nxml-auto-insert-xml-declaration-flag nil))

;; JSON handling (additional to lang-frontend)
(with-eval-after-load 'json-mode
  (bind-key "C-c C-f" 'json-mode-beautify json-mode-map))

;; JSONL (JSON Lines / Newline-delimited JSON)
(add-to-list 'auto-mode-alist '("\\.jsonl\\'" . json-mode))

;; Apache Thrift
(use-package thrift
  :mode "\\.thrift\\'")

;; HCL (HashiCorp Configuration Language) for Terraform
(use-package hcl-mode
  :mode "\\.hcl\\'")

(use-package terraform-mode
  :mode "\\.tf\\'")

;; INI files
(use-package ini-mode
  :mode "\\.ini\\'")

;; Environment files
(add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . conf-mode))

;; Properties files (Java)
(add-to-list 'auto-mode-alist '("\\.properties\\'" . conf-mode))

;; Log file viewing
(use-package logview
  :mode (("\\.[Ll][Oo][Gg]\\'" . logview-mode)
         ("\\.log\\.[0-9]+\\'" . logview-mode)))

;; Data visualization with gnuplot
(use-package gnuplot
  :commands gnuplot-mode
  :mode ("\\.gp\\'" . gnuplot-mode))

;; Apache Arrow Flight SQL (via shell commands)
(defun arrow-inspect-file ()
  "Inspect Arrow/Feather file using pyarrow."
  (interactive)
  (let* ((file (buffer-file-name))
         (python-script
          (format "import pyarrow as pa; import pyarrow.feather as feather; table = feather.read_table('%s'); print(table.schema); print(table.to_pandas())" file)))
    (if (executable-find "python3")
        (shell-command (format "python3 -c \"%s\"" python-script))
      (message "Install pyarrow to inspect Arrow files"))))

(add-to-list 'auto-mode-alist '("\\.arrow\\'" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.feather\\'" . fundamental-mode))

;; HDF5 support (via external tools)
(defun hdf5-view-structure ()
  "View HDF5 file structure using h5dump."
  (interactive)
  (let ((file (buffer-file-name)))
    (if (executable-find "h5dump")
        (shell-command (format "h5dump -H %s" file))
      (message "Install HDF5 tools (h5dump) to view HDF5 files"))))

(add-to-list 'auto-mode-alist '("\\.h5\\'" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.hdf5\\'" . fundamental-mode))

;; NetCDF support
(add-to-list 'auto-mode-alist '("\\.nc\\'" . fundamental-mode))

;; Binary file viewing with hexl-mode
(use-package hexl
  :ensure nil
  :commands hexl-mode)

;; Helper function to view binary data files
(defun view-binary-data-file ()
  "View binary data file in hexl-mode."
  (interactive)
  (hexl-mode))

(provide 'data-config)
;;; data-config.el ends here
