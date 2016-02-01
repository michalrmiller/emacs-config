; emacs -q -l ~/dev/ide/emacs/init.el

(add-to-list 'load-path "~/dev/ide/emacs")
(load-library "better-defaults")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

; Packages
(defvar my-packages '(cyberpunk-theme 
                      clojure-mode 
                      cider
                      paredit
                      rainbow-delimiters
                      nginx-mode
                      company
                      company-racer
                      racer
                      flycheck
                      flycheck-rust
                      rust-mode)
  "A list of packages to ensure are installed at launch.")

; Set CUA Mode
(cua-mode t)

; Line numbers
(global-linum-mode t)

; Setup tabs
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

; Init packages
(package-initialize)

; Refresh if needed
(when (not package-archive-contents)
  (package-refresh-contents))

; Load packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; Load Theme
(load-theme 'cyberpunk t)

; Clojure
;; require or autoload paredit-mode
(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))

; CIDER
;; Enable eldoc
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; Hide special buffers
(setq nrepl-hide-special-buffers t)
;; Enable pairedit
(add-hook 'cider-repl-mode-hook 'paredit-mode)
;; Enable rainbow parens
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
