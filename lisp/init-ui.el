;; cancel tool-bar, scroll-bar, menu-bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; show line numbers
(global-linum-mode t)
(setq linum-format "%.4d|")

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

;; load theme solarized
(load-theme 'solarized-dark t)

;; (global-set-key (kbd "C-SPC") nil)

;; cancel backup files
(setq make-backup-files nil)

(provide 'init-ui)
