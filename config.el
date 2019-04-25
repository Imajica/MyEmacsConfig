(defvar my-term-shell "/usr/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
(global-set-key (kbd "s-f") 'ansi-term)

(column-number-mode 1)
(line-number-mode 1)

(defun kill-curr-buffer()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c d w") `kill-whole-word)

(setq electric-pair-pairs '(
                             (?\{ . ?\})
                             (?\( . ?\))
                             (?\[ . ?\])
                             (?\" . ?\")
                             ))
(electric-pair-mode t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(add-to-list 'org-structure-template-alist
	       '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(use-package avy
  :ensure t
  :bind ("s-x" . avy-goto-char))

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(use-package sudo-edit
  :ensure t
  :bind
    ("s-e" . sudo-edit))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package dashboard
  :ensure t
  :config
    (dashboard-setup-startup-hook)
    ;; (setq dashboard-startup-banner "~/.emacs.d/img/dashLogo.png")
    (setq dashboard-items '((recents  . 5)
                            (projects . 5)))
    (setq dashboard-banner-logo-title ""))

(use-package company
  :ensure t
  :init
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (add-hook 'after-init-hook 'global-company-mode))
(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

(use-package diminish
  :ensure t
  :init
  (diminish 'which-key-mode)
  (diminish 'hungry-delete-mode)
  (diminish 'rainbow-delimiters-mode)
  (diminish 'flycheck-mode)
  (diminish 'helm-mode)
  (diminish 'anzu-mode)
  (diminish 'undo-tree-mode)
  (diminish 'projectile-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'yas-mode)
  (diminish 'beacon-mode)
)

(use-package symon
  :ensure t
  :bind
  ("s-t" . symon-mode))

(use-package nlinum
   :ensure t
   :config (global-nlinum-mode)
)
