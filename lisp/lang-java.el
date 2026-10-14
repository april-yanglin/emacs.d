;;; lang-java.el --- Java configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Java development configuration with LSP and eclipse jdtls

;;; Code:

;; LSP Java (Eclipse JDT Language Server)
(use-package lsp-java
  :hook ((java-mode . lsp-deferred)
         (java-mode . lsp-java-boot-lens-mode))
  :config
  (let ((lombok (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar")))
    (setq lsp-java-vmargs
          (append '("-Xmx2G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication")
                  ;; Only if present: a missing -javaagent jar stops jdtls from starting.
                  (when (file-exists-p lombok) (list (concat "-javaagent:" lombok))))))
  (setq lsp-java-java-path "java"
        lsp-java-format-enabled t
        lsp-java-save-actions-organize-imports t
        lsp-java-completion-favorite-static-members
        '("org.junit.Assert.*"
          "org.junit.Assume.*"
          "org.junit.jupiter.api.Assertions.*"
          "org.junit.jupiter.api.Assumptions.*"
          "org.junit.jupiter.api.DynamicContainer.*"
          "org.junit.jupiter.api.DynamicTest.*"
          "org.mockito.Mockito.*"
          "org.mockito.ArgumentMatchers.*"
          "org.mockito.Answers.*")
        lsp-java-import-gradle-enabled t
        lsp-java-import-maven-enabled t))

;; DAP mode for debugging
(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

(use-package dap-java
  :straight nil
  :after (lsp-java))

;; Spring Boot support
(use-package lsp-java-boot
  :straight nil
  :after lsp-java)

;; Maven integration
(use-package mvn
  :commands (mvn mvn-clean mvn-compile mvn-test))

;; Gradle support
(use-package gradle-mode
  :hook (java-mode . gradle-mode)
  :config
  (setq gradle-use-gradlew t))

;; Meghanada (alternative to LSP for Java)
;; Uncomment if you prefer meghanada over lsp-java
;; (use-package meghanada
;;   :defer t
;;   :hook (java-mode . meghanada-mode)
;;   :config
;;   (setq meghanada-java-path "java"
;;         meghanada-maven-path "mvn"))

(provide 'lang-java)
;;; lang-java.el ends here
