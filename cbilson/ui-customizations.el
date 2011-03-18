
(if window-system
    (progn
      (require 'color-theme)
      (add-to-list 'load-path (concat dotfiles-dir "cbilson/themes"))
      (load (concat dotfiles-dir "cbilson/themes/color-theme-library"))
      (require 'color-theme-sunburst)
      (color-theme-sunburst)))

