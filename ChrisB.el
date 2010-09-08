;;; My personalizations

(color-theme-twilight)

(load "gnuserv")
(gnuserv-start)

;;
;; misc
;;
(column-number-mode t)
(blink-cursor-mode t)
(auto-compression-mode 1)
(set-variable 'scroll-step 1)
(set-variable 'scroll-conservatively 5)
(set-variable 'default-truncate-lines 1)
(set-variable 'suggest-key-bindings t)

(add-to-list 'load-path (concat dotfiles-dir "vendor"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/clojure-mode"))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
; some other filename patterns that are XML
(setq auto-mode-alist (cons '("\\.xaml$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.msbuild$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.build$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.proj$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.csproj$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.fsproj$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.kml$" . nxml-mode) auto-mode-alist))

(org-remember-insinuate)
(require 'wb-line-number)

;;
;; Rebind a few keys
;;
(global-set-key (kbd "C-<left>") 'backward-word)
(global-set-key (kbd "C-<right>") 'forward-word)
(global-set-key (kbd "C-c C-r") 'remember)

(eval-after-load 'paredit
  '(progn (define-key paredit-mode-map (kbd "C-<left>") 'backward-word)
          (define-key paredit-mode-map (kbd "C-<right>") 'forward-word)))

;;
;; fsharp-mode
;;
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)
(set 'fsharp-indent-offset 3)

(setq inferior-fsharp-program
      (if (eq system-type 'windows-nt)
          "\"C:\\Program Files\\Microsoft F#\\v4.0\\fsi.exe\""
        "~/bin/fsi.exe --readline-"))

(setq fsharp-compiler
      (if (eq system-type 'windows-nt)
          "\"C:\\Program Files\\Microsoft F#\\v4.0\\fsc.exe\""
        "~/bin/fsc.exe --resident"))
	
;;
;; c# mode
;;
(setq auto-mode-alist
      (cons '("\\.cs$" . csharp-mode) auto-mode-alist))
      
;;
;; powershell mode
;;
(autoload 'powershell-mode "powershell-mode" "Major mode for editing powershell scripts." t)
(setq auto-mode-alist
      (cons '("\\.ps1$" . powershell-mode) auto-mode-alist))
      
;;
;; ruby stuffs
;;
(defconst ironruby-ir "C:/Program Files/IronRuby 1.0v4/bin/ir.exe")

(defun inf-iron-ruby ()
  "inferior ruby mode using IronRuby"
  (interactive)
  (run-ruby ironruby-ir "IronRuby"))

(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(require 'rspec-mode)
(add-hook 'rspec-mode-hook (define-key rspec-mode-keymap (kbd "C-1") 'rspec-verify-single))

(when (eq system-type 'windows-nt)
  ; without this emacs pauses a lot on window
  ; see http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/e3142de71f27b71b/72a40de2061f1a33?lnk=raot
  (setq w32-get-true-file-attributes nil)
  
  ; to get a list of all the fonts: (insert (prin1-to-string (x-list-fonts "*")))
  (setq w32-enable-synthesized-fonts t)

  ;  (set-default-font "-outline-Inconsolata-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1")

  (set-default-font "-outline-Consolas-normal-r-normal-normal-*-*-*-*-c-*-iso8859-1")
  (set-face-font 'italic "-outline-Consolas-normal-italic-normal-mono-*-*-*-*-c-*-iso8859-1")
  (set-face-font 'bold "-outline-Consolas-bold-normal-normal-mono-*-*-*-*-c-*-iso8859-1")

  ;; (set-default-font "-outline-Envy Code R-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1")
  ;; (set-face-font 'italic "-outline-Envy Code R-normal-italic-normal-mono-*-*-*-*-c-*-iso10646-1")
  ;; (set-face-font 'bold "-outline-Envy Code R-bold-normal-normal-mono-*-*-*-*-c-*-iso10646-1")

  )

;;
;; clojure stuff
;;
(require 'slime)
(require 'clojure-mode)
(require 'clojure-test-mode)

(add-hook 'clojure-mode-hook (define-key clojure-test-mode-map (kbd "C-1") 'clojure-test-run-tests))

(setq clojure-jar-file "/home/cbilson/src/clojure/clojure/clojure.jar")
(setq clojure-command (concat "java -cp "
                              clojure-jar-file
                              " clojure.main"))

(setq inferior-lisp-program clojure-command)

;;
;; git stuff
;;
(add-to-list 'load-path "~/.emacs.d/vendor/mo-git-blame")
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

