
(add-to-list 'load-path (concat dotfiles-dir "cbilson/ess-5.13"))

(load (concat dotfiles-dir "cbilson/ess-5.13/lisp/ess-site"))

(setq auto-mode-alist (cons '("\\.R$" . r-mode) auto-mode-alist))

