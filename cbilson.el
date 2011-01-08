;;; My personalizations

(if window-system
    (color-theme-twilight))

;;
;; Package Management
;;
(add-to-list 'package-archives
             '("technomancy" . "http://repo.technomancy.us/emacs/") t)

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
(add-to-list 'load-path (concat dotfiles-dir "vendor/midje"))
(add-to-list 'load-path (concat dotfiles-dir "elpa-to-submit/fsharp"))

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
(setq auto-mode-alist (cons '("\\.conkererrc$" . js2-mode) auto-mode-alist))

(org-remember-insinuate)
(require 'wb-line-number)

;;
;; Rebind a few keys
;;
(global-set-key (kbd "C-<left>") 'backward-word)
(global-set-key (kbd "C-<right>") 'forward-word)
(global-set-key (kbd "C-c C-r") 'remember)
(global-set-key (kbd "C-c w") 'rotate-windows)
(global-set-key (kbd "C-x C-a") '(lambda () (interactive) (ansi-term "/bin/zsh")))

;; (eval-after-load 'paredit
;;   '(progn (define-key paredit-mode-map (kbd "C-<left>") 'backward-word)
;;           (define-key paredit-mode-map (kbd "C-<right>") 'forward-word)))

;;
;; fsharp-mode
;;
(require 'fsharp)
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

;;
;; python stuff
;;
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil)
  )

;; (eval-after-load "pymacs"
;;   ;; '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY)
;;   (load-ropemacs)
;;   )

;;
;; haskel stuff
;;
(require 'haskell-mode)
(setq auto-mode-alist (cons '("\\.hs$" . haskell-mode) auto-mode-alist))


;;
;; clojure stuff
;;
(require 'slime)
(require 'clojure-mode)
(require 'clojure-test-mode)
(require 'midje-mode)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map (kbd "C-c c") 'comment-region)
             (define-key clojure-mode-map (kbd "C-c u") 'uncomment-region)
             (define-key clojure-mode-map (kbd "C-S-w") 'mark-sexp)
             (define-key clojure-test-mode-map (kbd "C-1") 'midje-check-fact)
             (define-key clojure-test-mode-map (kbd "C-2") 'midje-recheck-last-fact-checked)))

(add-hook 'clojure-mode-hook 'midje-mode)

(setq clojure-jar-file "/home/cbilson/src/clojure/clojure/clojure.jar")
(setq clojure-command (concat "java -cp "
                              clojure-jar-file
                              " clojure.main"))

(setq inferior-lisp-program clojure-command)

(add-hook 'clojure-mode-hook 'paredit-mode)
(autoload 'clojure-test-mode "clojure-test-mode" "Clojure test mode" t)
(add-hook 'clojure-mode-hook
          (lambda () (save-excursion
                  (goto-char (point-min))
                  (if (search-forward "(deftest" nil t)
                      (clojure-test-mode)))))

(add-hook 'clojure-mode-hook 'esk-remove-elc-on-save)

(add-hook 'slime-mode-hook (lambda () (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(defun sl4 ()
  "Make it easier to connect to slime"
  (interactive)
  (slime-connect "localhost" 4005))

(defun lein-swank ()
  (interactive)
  (let* ((project-file (locate-dominating-file default-directory "project.clj"))
        (root (if (not project-file) (locate-dominating-file "~/src/clojure/scratch" "project.clj") project-file)))
    (when (not root)
      (error "Not in a Leiningen project."))
    ;; you can customize slime-port using .dir-locals.el
    (shell-command (format "cd %s && lein swank %s &" root slime-port)
                   "*lein-swank*")
    (set-process-filter (get-buffer-process "*lein-swank*")
                        (lambda (process output)
                          (when (string-match "Connection opened on" output)
                            (slime-connect "localhost" slime-port)
                            (set-process-filter process nil))))
    (message "Starting swank server...")))

(defun lein-scratch ()
  (interactive)
  (cd "~/src/clojure/scratch")
  (lein-swank))

;;
;; git stuff
;;
(add-to-list 'load-path "~/.emacs.d/vendor/mo-git-blame")
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(defun toggle-fullscreen (&optional f)
  "Toggles whether or not the window is fullscreen"
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;;(add-hook 'window-setup-hook 'toggle-fullscreen)

(if (eq system-type 'windows-nt)
    (progn 
      ;; without this emacs pauses a lot on window
      ;; see http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/e3142de71f27b71b/72a40de2061f1a33?lnk=raot
      (setq w32-get-true-file-attributes nil)
      
      ;; to get a list of all the fonts: (insert (prin1-to-string (x-list-fonts "*")))
      (setq w32-enable-synthesized-fonts t)

      ;; (set-default-font "-outline-Consolas-normal-r-normal-normal-*-*-*-*-c-*-iso8859-1")
      ;; (set-face-font 'italic "-outline-Consolas-normal-italic-normal-mono-*-*-*-*-c-*-iso8859-1")
      ;; (set-face-font 'bold "-outline-Consolas-bold-normal-normal-mono-*-*-*-*-c-*-iso8859-1")
      
      ;; (set-default-font "-outline-Envy Code R-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1")
      ;; (set-face-font 'italic "-outline-Envy Code R-normal-italic-normal-mono-*-*-*-*-c-*-iso10646-1")
      ;; (set-face-font 'bold "-outline-Envy Code R-bold-normal-normal-mono-*-*-*-*-c-*-iso10646-1")
      (set-default-font "-outline-Inconsolata-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1"))
  (progn
    (set-default-font "-bitstream-Meslo LG L-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")))

;;
;; Rotates window positions
;;
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))
                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))
                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;;
;; Wanderlust
;;
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "cbilson@gmail.com") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t) 

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "cbilson")
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

(setq wl-default-folder "%inbox")
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t) 

(setq elmo-imap4-use-modified-utf7 t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

