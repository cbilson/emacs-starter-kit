;;
;; c# mode
;;
(require 'csharp-mode)

(setq auto-mode-alist
      (cons '("\\.cs$" . csharp-mode) auto-mode-alist))
      
(provide 'csharp-customizations)
