(require 'package)  
(setq package-archives  
      '(("gnu"   . "https://elpa.gnu.org/packages/")  
        ("melpa" . "https://melpa.org/packages/")))  
(package-initialize)  

(unless (package-installed-p 'use-package)  
  (package-refresh-contents)  
  (package-install 'use-package))  

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; setup meow
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   '("f" . consult-fd)
   '("s" . consult-ripgrep)
   '("b" . consult-buffer)
   '("B" . consult-buffer)
   '("r" . consult-register)
   '("g" . consult-git-grep)
   '("y" . consult-yank-from-kill-ring)
   '("_" . consult-recent-file)
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("/" . consult-line)
   '("<escape>" . ignore)

   ;; sensible indentation
   '(">" . indent-rigidly-right-to-tab-stop)
   '("<" . indent-rigidly-left-to-tab-stop)
   '("=" . indent-region)

   ;; jump
   '("{" . scroll-down)  
   '("}" . scroll-up)

   ;; vim-styled window switching
   '("C-w h" . windmove-left)
   '("C-w l" . windmove-right)
   '("C-w j" . windmove-down)
   '("C-w k" . windmove-up)
   '("C-w v" . split-window-right)
   '("C-w e" . split-window-below)
   '("C-w c" . delete-window)
   '("C-w o" . delete-other-windows)

   '(": q" . save-buffers-kill-emacs)
   '(": shift+q" . save-buffers-kill-terminal)
   '(": w" . save-buffer)
   '(": r" . meow-find-ref)
   ))

;; setup packages
(use-package meow
  :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1))

(use-package gruvbox-theme
  :ensure t 
  :config
  (load-theme 'gruvbox-dark-hard t)) 

(use-package consult
  :ensure t)

(use-package vertico
  :ensure t)
 
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package wakatime-mode
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package nix-mode
  :ensure t)

(use-package nixfmt
  :ensure t)

(use-package magit
  :ensure t)

(use-package nushell-mode
  :ensure t)

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

;; we are using C-w for window management
(global-set-key (kbd "M-d") #'kill-region)
(setq meow--kbd-kill-region "M-d")

;; set options
(setq display-line-numbers-type 'relative)
(setq custom-file "~/.emacs.custom.el")
(setq color-column 80)
(setq inhibit-startup-screen t)
(setq confirm-non-existent-file-or-buffer nil)
(setq auto-save-visited-mode -1)
(setq scroll-conservatively 101)
(setq scroll-margin 5)
(setq recentf-mode 1)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)
(setq display-line-numbers-background nil)
(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil
                    :family "Iosevka Nerd Font" 
                    :height 120)
(set-face-background 'line-number nil)
(set-face-background 'line-number-current-line nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)
(save-buffer)
(global-display-line-numbers-mode)
(vertico-mode)
(global-wakatime-mode)
(display-battery-mode)
(display-time-mode)
