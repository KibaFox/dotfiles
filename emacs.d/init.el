; Bootstrap straight.el (https://github.com/raxod502/straight.el)
; This replaces package.el and allows for reproducible package management.
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

; Install use-package (https://github.com/jwiegley/use-package)
; Keep package config organized.
(straight-use-package 'use-package)


; Editor Options ---------------------------------------------------------------

; Disable the menu bar
(menu-bar-mode -1)

; Packages ---------------------------------------------------------------------

; Use straight by default with use-package.
(setq straight-use-package-by-default t)

; https://www.emacswiki.org/emacs/Evil
(use-package evil
  :config
    (evil-mode 1)
)

; https://github.com/keith/evil-tmux-navigator
(use-package navigate
  :straight (navigate :type git :host github :repo "keith/evil-tmux-navigator")
  :after evil
)

; https://github.com/editorconfig/editorconfig-emacs
(use-package editorconfig
  :config
    (editorconfig-mode 1)
)

; https://github.com/Malabarba/smart-mode-line
(use-package smart-mode-line
  :init
    (setq sml/no-confirm-load-theme t)
  :config
    (sml/setup)
)

; https://github.com/Greduan/emacs-theme-gruvbox
(use-package gruvbox-theme
  :after smart-mode-line
  :config
    (load-theme 'gruvbox-dark-medium t)
)

; Keybindings ------------------------------------------------------------------

(use-package general
  :config
  ;(general-define-key :states 'motion "C-h" 'evil-window-left)
  ;(general-define-key :states 'motion "C-j" 'evil-window-down)
  ;(general-define-key :states 'motion "C-k" 'evil-window-up)
  ;(general-define-key :states 'motion "C-l" 'evil-window-right)
)

