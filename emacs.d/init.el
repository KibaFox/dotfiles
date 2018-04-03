;;; init.el --- My personal Emacs config
;;; Commentary:
;;; Code:

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
; Use straight by default with use-package.
(setq straight-use-package-by-default t)

; Editor Options ---------------------------------------------------------------

(prefer-coding-system 'utf-8)

;; Save all tempfiles in ~/.local/share/emacs/
(defconst emacs-tmp-dir (expand-file-name "~/.local/share/emacs"))
(unless (file-directory-p emacs-tmp-dir) (make-directory emacs-tmp-dir))
(setq backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))

(use-package whitespace ; Visualize and cleanup whitespace
  :init
  (setq whitespace-style '(face spaces tabs newline trailing empty
                            spaces-before-tab tab-mark))
  (setq whitespace-action '(auto-cleanup)) ; automatically clean trailing space
  (setq whitespace-display-mappings
    '((space-mark   ?\    [?\xB7]     [?.])      ; space
      (space-mark   ?\xA0 [?\xA4]     [?_])      ; hard space
      (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n])  ; end-of-line
      (tab-mark     ?\t   [?\xBB ?\t] [?\\ ?\t]) ; tab
      ))
  :config
  (add-hook 'after-init-hook 'global-whitespace-mode))

; Treat tmux-256color as if it were screen-256color, which Emacs supports.
(add-to-list 'term-file-aliases
  '("tmux-256color" . "screen-256color"))

;; Hide menu bar, tool bar, and scroll bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Hide splash screen and banner
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)

(setq visual-bell 1) ; no bell sound

;; Enable mouse support in the terminal
;; https://stackoverflow.com/a/8859057
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(use-package flyspell ; spell check
  :hook ((prog-mode . flyspell-prog-mode)
          (text-mode . flyspell-mode)))


; Packages ---------------------------------------------------------------------

; https://company-mode.github.io/
(use-package company ; in-buffer completion framework
  :config
  (global-company-mode))

; https://github.com/editorconfig/editorconfig-emacs
(use-package editorconfig
  :config
    (editorconfig-mode 1)
)

; https://www.emacswiki.org/emacs/Evil
(use-package evil
  :init
    ; Give us back Ctrl+U for vim emulation
    (setq evil-want-C-u-scroll t)
  :config
    (evil-mode 1)
)

; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell ; Ensure PATH in Emacs is the same as shell.
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

; http://www.flycheck.org/
(use-package flycheck ; Syntax checking.
  :hook (after-init-hook . 'global-flycheck-mode))

; https://github.com/Greduan/emacs-theme-gruvbox
(use-package gruvbox-theme
  :after smart-mode-line
  :config
    (load-theme 'gruvbox-dark-medium t)
)

; https://github.com/abo-abo/swiper
(use-package swiper ; ivy + counsel + swiper
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  )


; https://github.com/joshwnj/json-mode
(use-package json-mode
  :mode "\\.json\\'"
)

; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :mode "\\.md\\'"
)

; https://github.com/keith/evil-tmux-navigator
(use-package navigate
  :straight (navigate :type git :host github :repo "keith/evil-tmux-navigator")
  :after evil
)

; https://github.com/Malabarba/smart-mode-line
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  (setq rm-blacklist ; Hide some minior modes.
    (format "^ \\(%s\\)$"
      (mapconcat #'identity
        '(
           "EditorConfig"
           "Undo-Tree"
           "company"
           "server"
           "WS"
           )
        "\\|")))
  :config
  (sml/setup))

; https://github.com/syohex/emacs-terraform-mode
(use-package terraform-mode
  :mode "\\.tf\\'")

; https://github.com/rafalcieslak/emacs-company-terraform
(use-package company-terraform ; completions for terraform
  :commands company-terraform-init
  :hook (terraform-mode . company-terraform-init))

; https://github.com/justbur/emacs-which-key
(use-package which-key ; display keybindings in popup
  :config
  (which-key-mode))

; Keybindings ------------------------------------------------------------------

(use-package general
  :config
  ;(general-define-key :states 'motion "C-h" 'evil-window-left)
  ;(general-define-key :states 'motion "C-j" 'evil-window-down)
  ;(general-define-key :states 'motion "C-k" 'evil-window-up)
  ;(general-define-key :states 'motion "C-l" 'evil-window-right)
)
