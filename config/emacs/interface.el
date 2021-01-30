;; Fonts
(set-face-attribute 'default nil :font "Source Code Pro" :height alex/default-font-size)
;; set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height alex/default-font-size)
;; set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Source Code Pro" :height alex/default-variable-font-size :weight 'regular)
(custom-set-faces
 '(font-lock-keyword-face ((t (:slant italic)))))

;; Org-mode fontface
(defun alex/org-font-setup()
  ;; replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Ubuntu" :weight 'medium :height (cdr face)))
  ;; ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

;; Icons
(use-package all-the-icons)

;; Theme
(use-package doom-themes
  :init (load-theme 'doom-dracula t))

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
