; emacs -q -l ~/dev/ide/emacs/init.el

(add-to-list 'load-path "~/dev/ide/emacs")
(load-library "better-defaults")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

; Packages
(defvar my-packages '(cyberpunk-theme 
                      clojure-mode 
                      paredit
                      rainbow-delimiters)
  "A list of packages to ensure are installed at launch.")

; Set CUA Mode
(cua-mode t)

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
