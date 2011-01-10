;;
;; powershell mode
;;
(autoload 'powershell-mode "powershell-mode" "Major mode for editing powershell scripts." t)
(setq auto-mode-alist
      (cons '("\\.ps1$" . powershell-mode) auto-mode-alist))
      
(provide 'powershell-customizations)
