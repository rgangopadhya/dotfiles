-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
local telescope = require("telescope")
telescope.load_extension("file_browser")
return telescope.load_extension("fzf")
