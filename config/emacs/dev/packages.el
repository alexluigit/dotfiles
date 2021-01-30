;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :init
  (when (file-directory-p "~/Dev")
    (setq projectile-project-search-path '("~/Dev")))
  (setq projectile-switch-project-action #'projectile-dired))
(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Magit
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
(use-package evil-magit
  :after magit)
(evil-define-key* evil-magit-state magit-mode-map [escape] nil)
(evil-define-key evil-magit-state magit-mode-map "e" 'magit-section-backward)
(evil-define-key evil-magit-state magit-mode-map "n" 'magit-section-forward)
(evil-define-key evil-magit-state magit-mode-map "p" 'magit-ediff-dwim)
;; (evil-define-key* evil-magit-state magit-mode-map "e" nil)
;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge)

;; Commenting
(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

;; Colorize parentheses
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


