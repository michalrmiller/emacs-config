; emacs -q -l ~/dev/ide/emacs/init.el

(add-to-list 'load-path "~/dev/ide/emacs")
(load-library "better-defaults")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

; Init packages
(package-initialize)

; Packages
(defvar my-packages '(cyberpunk-theme
                      solarized-theme
                      smart-mode-line
                      smart-mode-line-powerline-theme
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
                      rust-mode
                      org
                      go-mode
                      es-mode
                      elixir-mode
                      eyebrowse
                      yaml-mode
                      indent-tools
                      elpy
                      )
  "A list of packages to ensure are installed at launch.")

; Set CUA Mode
(cua-mode t)

; Line numbers
(global-linum-mode t)

; Setup tabs
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(add-hook 'go-mode-hook 
          (lambda ()
            (setq-default) 
            (setq tab-width 4) 
            (setq standard-indent 4) 
            (setq indent-tabs-mode nil)))

; Refresh if needed
(when (not package-archive-contents)
  (package-refresh-contents))

; Load packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; Load Theme
(load-theme 'cyberpunk t)
;(load-theme 'solarized-dark t)

; Load Smart Line Mode
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'powerline)
(sml/setup)

;; no startup msg  
(setq inhibit-startup-message t)

;; EyeBrowse
(eyebrowse-mode t)

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

;; YAML
;;(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Python
;; Requires: pip install jedi flake8 autopep8
(elpy-enable)
