;;; 70-core-lsp.el --- lsp support

(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-include-signture t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-enable nil))

(use-package lsp-mode
  :custom
  (lsp-session-file (concat cache-dir ".lsp-session-v1"))
  (lsp-prefer-flymake nil))

;; (use-package eglot
;;   :config
;;   (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
;;   :hook (scala-mode . eglot-ensure))

(use-package helm-lsp
  :after helm lsp-mode)

(use-package company-lsp
  :after company-mode
  :custom
  (company-lsp-cache-candidates nil)
  (company-lsp-async t)
  (company-lsp-enable-recompletion t))

(provide '70-core-lsp)
;;; 70-core-lsp.el ends here
