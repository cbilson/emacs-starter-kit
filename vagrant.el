(setq user-specific-dir (concat dotfiles-dir "cbilson"))

(if (file-exists-p user-specific-dir)
    (progn
      (add-to-list 'load-path user-specific-dir)
      (mapc #'load (directory-files user-specific-dir nil "*.el$"))))
