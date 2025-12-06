;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-

;;; Commentary:
;; Early initialization file loaded before package system and GUI.
;; Used for performance optimizations.

;;; Code:

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

;; Increase GC threshold during startup for better performance
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Restore GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; Disable unnecessary UI elements early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Prevent resizing frame
(setq frame-inhibit-implied-resize t)

;; Disable startup screen
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Native compilation settings
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t))

;;; early-init.el ends here
