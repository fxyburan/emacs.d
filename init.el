
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; set melpa package source
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;; check & install dependent packages
(defvar dependent-packages '(
		       solarized-theme
		       ) "Default packages")

(setq package-selected-packages 'dependent-packages)

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load theme solarized
(load-theme 'solarized-dark t)

;; cancel backup files
(setq make-backup-files nil)
