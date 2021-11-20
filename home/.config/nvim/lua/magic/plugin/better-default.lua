local _2afile_2a = ".config/nvim/fnl/magic/plugin/better-default.fnl"
local _2amodule_name_2a = "magic.plugin.better-default"
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
local nvim = autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
nvim.g.vim_better_default_persistent_undo = true
nvim.ex.runtime_("plugin/default.vim")
nvim.ex.set("nonumber")
nvim.ex.set("norelativenumber")
nvim.ex.set("wrap")
nvim.ex.set("wildmode=full")
nvim.ex.set("wildoptions=pum")
nvim.ex.set("listchars-=eol:\226\134\181")
nvim.o.undodir = (nvim.fn.stdpath("data") .. "/undo")
return nvim.ex.set("clipboard-=unnamedplus")