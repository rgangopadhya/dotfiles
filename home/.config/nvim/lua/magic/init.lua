local _2afile_2a = ".config/nvim/fnl/magic/init.fnl"
local _2amodule_name_2a = "magic.init"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local nvim, plugin = autoload("aniseed.nvim"), autoload("magic.plugin")
do end (_2amodule_locals_2a)["nvim"] = nvim
_2amodule_locals_2a["plugin"] = plugin
nvim.o.termguicolors = true
nvim.o.mouse = "a"
nvim.o.updatetime = 500
nvim.o.timeoutlen = 500
nvim.o.sessionoptions = "blank,curdir,folds,help,tabpages,winsize"
nvim.o.inccommand = "split"
nvim.ex.set("spell")
nvim.ex.set("list")
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
return plugin.use("Olical/aniseed", {}, "Olical/conjure", {}, "PeterRincker/vim-argumentative", {}, "airblade/vim-gitgutter", {}, "clojure-vim/clojure.vim", {}, "clojure-vim/vim-jack-in", {}, "easymotion/vim-easymotion", {}, "folke/which-key.nvim", {}, "guns/vim-sexp", {}, "hrsh7th/nvim-compe", {}, "itchyny/lightline.vim", {}, "jiangmiao/auto-pairs", {mod = "auto-pairs"}, "junegunn/fzf", {}, "junegunn/fzf.vim", {}, "liuchengxu/vim-better-default", {mod = "better-default"}, "mbbill/undotree", {}, "radenling/vim-dispatch-neovim", {}, "srcery-colors/srcery-vim", {mod = "srcery"}, "tami5/compe-conjure", {}, "tpope/vim-abolish", {}, "tpope/vim-commentary", {}, "tpope/vim-dispatch", {}, "tpope/vim-eunuch", {}, "tpope/vim-fugitive", {}, "tpope/vim-repeat", {}, "tpope/vim-sexp-mappings-for-regular-people", {}, "tpope/vim-sleuth", {}, "tpope/vim-surround", {}, "tpope/vim-unimpaired", {}, "tpope/vim-vinegar", {}, "w0rp/ale", {mod = "ale"}, "wbthomason/packer.nvim", {})