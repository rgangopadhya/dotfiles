;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(local telescope (require :telescope))
(telescope.load_extension :file_browser)
(telescope.load_extension :fzf)
