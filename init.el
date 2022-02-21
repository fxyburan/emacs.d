(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))

(require 'init-elpa)

(require 'init-packages)

(require 'init-ui)

(require 'init-org-mode)

(require 'init-lsp-c)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cdlatex cmake-ide cmake-mode cmake-project auctex eglot ccls lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file "~/.emacs.d/elpa/cdlatex-20210804.452/cdlatex.el")
(setq-default TeX-master nil)
(mapc (lambda (mode)
	(add-hook 'LaTeX-mode-hook mode))
      (list 'turn-on-cdlatex
	    'reftex-mode
	    'outline-minor-mode
	    'auto-fill-mode
	    'flyspell-mode
	    'hide-body t
	    ))
