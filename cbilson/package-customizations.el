
;;
;; Package Management
;;

;; additional packages I want installed
(dolist (package '(clojure-mode
                   clojure-test-mode
                   color-theme
                   dired-isearch
                   haml-mode
                   js2-mode
                   markdown-mode
                   muse
                   org
                   paredit
                   rinari
                   rspec-mode
                   ruby-electric
                   rvm
                   sass-mode
                   slime
                   yasnippet-bundle
                   zenburn))
  (add-to-list 'starter-kit-packages package))

