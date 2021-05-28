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

(provide 'init-packages)
