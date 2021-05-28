(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp")))

(require 'init-elpa)

(require 'init-packages)

(require 'init-ui)

(require 'init-org-mode)

(require 'init-lsp-c)
