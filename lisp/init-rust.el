(use-package rustic
  :ensure
  :bind (:map rustic-mod-map
      ("M-j" . lsp-ui-imenu)
      ("M-?" . lsp-find-references)
      ("C-c C-c l" . flycheck-list-errors)
      ("C-c C-c a" . lsp-execute-code-action)
      ("C-c C-c r" . lsp-rename)
      ("C-c C-c q" . lsp-wordspace-restart)
      ("C-c C-c Q" . lsp-workspace-shutdown)
      ("C-c C-c s" . lsp-rust-analyzer-status))
  :confi
  ;; 减少闪动可以取消这里的注释
  ;; (setq lsp-eldoc-hook nil)      
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; 注释下面这行可以禁用保存时 rustfmt 格式化
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; 所以运行 C-c C-c C-r 无需确认就可以工作，但不要尝试保存不是文件访问的 rust 缓存。
  ;; 一旦 https://github.com/brotzeit/rustic/issues/253 问题处理了
  ;; 就不需要这个配置了
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; 保存时使用什么进行检查，默认是 "check"，我更推荐 "clippy"
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensuer
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; 弹层延迟显示时长
  ;; (company-begin-commands nil) ;; 取消注释可以禁用弹层
  :bind
  (:map compnay-active-map
    ("C-n". company-select-next)
    ("C-p". company-select-previous)
    ("M-<". company-select-first)
    ("M->". company-select-last)))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode)
  )

(use-package company
  ;; ... 接上面 ...
  (:map company-mod-map
    ("<tab>". tab-indent-or-complete)
    ("TAB". tab-indent-or-complete)
  )
)

(defun company-yasnippet-or-complete ()
  (interactive)
  (or (do-yas-expand)
    (company-complete-common))
)

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)
      )
    )
  )
)

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)
  )
)

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
    (minibuffer-complete)
    (if (or (not yas/minor-mod)
          (null (do-yas-expand))
        )
        (if (check-expansion)
          (company-complete-common)
          (indent-for-tab-command)
        )
    )
  )
  )

(use-package flycheck :ensure)

;;(add-hook 'rust-mode-hook
;;          (lambda () (setq indent-tabs-mode nil)))

;;(setq rust-format-on-save t)

;;(add-hook 'rust-mode-hook
;;          (lambda () (prettify-symbols-mode)))

;;(use-package tree-sitter
;;  :config
;;  (require 'tree-sitter-langs)
;;  (global-tree-sitter-mode)
;;  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;;(add-hook 'rust-mode-hook 'eglot-ensure)

;;(add-hook 'rust-mode-hook #'lsp)
