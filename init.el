(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(require 'use-package)

(add-to-list 'load-path "~/.emacs.d/custom")
(when window-system (global-hl-line-mode) t)

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(setq-default c-basic-offset 4)
(set-default-font "xos4 Terminus" nil t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(helm-follow-mode-persistent t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (nlinum symon diminish spaceline dashboard rainbow-delimiters sudo-edit hungry-delete avy org-bullets beacon which-key markdown-preview-mode company-c-headers irony company-irony spacemacs-theme auctex company-math markdown-mode gh-md evil function-args zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu)))
 '(speedbar-show-unknown-files t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET
(require 'yasnippet)
(yas-global-mode 1)

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; (use-package company-irony
;;   :ensure t
;;   :config
;;   (require 'company)
;;   (add-to-list 'company-backends 'company-irony))

;; (use-package irony
;;   :ensure t
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; (with-eval-after-load 'company
;;   (add-hook 'c++-mode-hook 'company-mode)
;;   (add-hook 'c-mode-hook 'company-mode))
;;(with-eval-after-load 'company
;;  (define-key company-active-map (kbd "M-n") 0)
;;  (define-key company-active-map (kbd "M-p") 0)
;;  (define-key company-active-map (kbd "C-n") # company-select-next)
;;  (define-key company-active-map (kbd "C-p") # company-select-previous))
;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq company-backends (delete 'company-semantic company-backends))
;;(define-key c-mode-map  [(tab)] 'company-complete)
;;(define-key c++-mode-map  [(tab)] 'company-complete)
;;(defun my-latex-mode-setup ()
;; (setq-local company-backends
;;              (append '((company-math-symbols-latex company-math-symbols-unicode))
;;                      company-backends ) ) )

;;(add-hook 'LaTeX-mode-hook 'my-latex-mode-setup)
;;(add-hook 'after-init-hook 'global-company-mode)

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)



(require 'tex)
(TeX-global-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(add-to-list 'company-backends 'company-c-headers)
(load-theme 'spacemacs-dark)

(show-paren-mode 1)
(setq show-paren-delay 0)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
(setq column-number-mode t)
(global-set-key "\C-x\C-\\" 'goto-last-change)

;;((company-clang-arguments "-I/home/vardas/slurm_versions/slurm-for-process-placement/slurm-18.08.1/slurm" "-I/home/vardas/slurm_versions/slurm-for-process-placement/slurm-18.08.1/src")
;; (company-clang-arguments "-I/home/vardas/slurm_versions/slurm-for-process-placement/slurm-18.08.1/src")
;; (company-clang-arguments "-I/home/vardas/slurm_versions/slurm-for-process-placement/slurm-18.0.08.1/")
;; (company-clang-arguments "-I/home/vardas/slurm_versions/slurm-for-process-placement/slurm-18.0.08.1/src/*"))
