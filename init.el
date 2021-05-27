
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; set melpa package source
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(unless (bound-and-true-p package--initialized)
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))

;; check & install dependent packages
(defvar dependent-packages '(solarized-theme
			     company
			     use-package
			     lsp-mode
			     which-key
			     dap-mode
			     ) "Default packages")

(setq package-selected-packages 'dependent-packages)

(require 'cl)
(defun dependent-packages-installed-p()
  (cl-loop for pkg in dependent-packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

(unless (dependent-packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg dependent-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; cancel tool-bar, scroll-bar, menu-bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; show line numbers
(global-linum-mode t)

;; delete-selection-mode
(delete-selection-mode t)

;; cancel inhibit splash screen
(setq inhibit-splash-screen t)

;; fullscreen at startup
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; show parentheses matching
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; highlight current line
(global-hl-line-mode t)

;; set cursor type
(setq-default cursor-type 'bar)

;; TODO recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; open init.el
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

;; (use-package lsp-mode :commands lsp)
;; (use-package lsp-ui :commands lsp-ui-mode)
;; (use-package company :commands company-lsp)
;; (use-package ccls
;; 	     :hook ((c-mode c++-mode objc-mode cuda-mode)
;; 		    (lambda () (require 'ccls) (lsp))))

;; (setq ccls-executable "/home/vontroy/dev/ccls/Release/ccls")

(setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))

(add-hook 'after-init-hook 'global-company-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (eglot ccls lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; lsp-mode setup
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
	 (c-mode . lsp-deferred)
         (python-mode . lsp-deferred))
  :commands (lsp lsp-deferred))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))

;; clangd setup
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; load theme solarized
(load-theme 'solarized-dark t)

;; cancel backup files
(setq make-backup-files nil)
