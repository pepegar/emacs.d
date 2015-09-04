;; Improve Emacs performance
(setq max-specpdl-size (* max-specpdl-size 15)
      max-lisp-eval-depth (* max-lisp-eval-depth 30))

;; MELPA and Marmalade repos for packages.
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Bootstrap 'paradox-package-manager
(unless (package-installed-p 'paradox)
  (package-refresh-contents)
  (package-install 'paradox))

(package-install 'helm)
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x) ; replace M-x with helm-M-X
(global-set-key (kbd "C-x C-f") 'helm-find-files) ; replace find-file
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t
      ;; Enable autoresize
      helm-autoresize-mode t;
      helm-autoresize-max-height 20
      ;; Enable fuzzy matching globally in helm
      ;; Not working in helm-M-x
      helm-mode-fuzzy-match t
      helm-completion-in-region-fuzzy-match t
      ;; Fix fuzzy matching in helm-M-x
      helm-M-x-fuzzy-match t)

(helm-mode t)

;; ido-vertical-mode package
;; (paradox-require 'ido-vertical-mode)
;; (ido-mode t)
;; (ido-vertical-mode t)

;; common lisp package
(paradox-require 'cl)

;; powerline
(paradox-require 'powerline)
(powerline-center-theme)
(setq powerline-default-separator 'contour)

;; web-mode package
(paradox-require 'web-mode)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-script-padding 2)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "Snow3")
(set-face-attribute 'web-mode-current-element-highlight-face nil :background "#073642")
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; emmet-mode package
(paradox-require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; auto-complete package
(paradox-require 'auto-complete)
(global-auto-complete-mode t)

;; move-lines package
(add-to-list 'load-path "~/.emacs.d/non-elpa/move-lines")
(require 'move-lines)
(move-lines-binding)

;; projectile package
;; (paradox-require 'projectile)
;; (projectile-global-mode t)

;; neotree package
(paradox-require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; magit package
(paradox-require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")

;; markdown package
(paradox-require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.mdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))

;; linum-off package
(paradox-require 'linum-off)

;; undo-tree package
(paradox-require 'undo-tree)
(global-undo-tree-mode t)

;; js2-mode package
(paradox-require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; autocomplete for js2-mode package
(paradox-require 'ac-js2)
(setq ac-js2-evaluate-calls t)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; livedown package
(add-to-list 'load-path "~/.emacs.d/non-elpa/emacs-livedown")
(require 'livedown)

;; highlight-chars package
(paradox-require 'highlight-chars)
(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
(add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (eq major-mode 'ibuffer-mode)
              (remove-hook 'font-lock-mode-hook
                           'hc-highlight-trailing-whitespace)
              (hc-dont-highlight-trailing-whitespace))))

;; IBuffer package
;; (paradox-require 'ibuffer)

;; misc package for extra functionality
(require 'misc)

;; nlinum package
(paradox-require 'nlinum)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My personal configurations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Solarized Dark Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)

(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil
              tab-always-indent nil)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; (if (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(setq show-paren-style 'expression)
(column-number-mode t)
(electric-pair-mode t)
(delete-selection-mode t)
(global-nlinum-mode t)
(global-auto-revert-mode t)
(setq nlinum-format "%4d")
;; (global-hl-line-mode t)
(global-visual-line-mode t)
(setq make-backup-files nil)

(setq doc-view-ghostscript-program "/usr/local/bin/gs")

;; Font configuration
(set-face-attribute 'default nil :font "DejaVu Sans Mono")
(set-frame-font "DejaVu Sans Mono 9" nil t)
;; Encoding configuration
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; Remap left-option-key to meta-key
(if (eq system-type 'darwin)
  (setq ns-command-modifier 'meta)
  (setq ns-option-modifier 'meta)
)
(setq ns-right-command-modifier 'none)
(setq ns-right-option-modifier 'none)
;; (setq inhibit-startup-screen t)

;; Comment line/region function. Bind to C-c C-c
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
      (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position))
    )
    (comment-or-uncomment-region beg end)
  )
)

;; Key bindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-z")     'undo-tree-undo)
(global-set-key (kbd "C-S-z")   'undo-tree-redo)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; TEMPORARY - Ciao configuration - Prolog
(if (file-exists-p "/usr/local/lib/ciao/ciao-1.14/ciao-mode-init.el")
    (load-file "/usr/local/lib/ciao/ciao-1.14/ciao-mode-init.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ciao-first-indent-width 2)
 '(ciao-indent-width 2)
 '(livedown:autostart t)
 '(livedown:open t)
 '(livedown:port 1337)
 '(markdown-indent-on-enter nil)
 '(paradox-github-token t)
 '(sh-indentation 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-dir-link-face ((t (:foreground "DeepSkyBlue"))))
 '(neo-expand-btn-face ((t (:foreground "SkyBlue"))))
 '(neo-file-link-face ((t (:foreground "White"))))
 '(neo-header-face ((t (:foreground "lightBlue" :weight bold)))))