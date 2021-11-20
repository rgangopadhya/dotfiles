local _2afile_2a = ".config/nvim/fnl/magic/plugin/auto-pairs.fnl"
local _2amodule_name_2a = "magic.plugin.auto-pairs"
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
local nvim, _ = autoload("aniseed.nvim"), nil
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["_"] = _
local function setup()
  local auto_pairs = nvim.g.AutoPairs
  auto_pairs["'"] = nil
  auto_pairs["`"] = nil
  nvim.b.AutoPairs = auto_pairs
  return nil
end
_2amodule_2a["setup"] = setup
vim.cmd(("augroup " .. "auto-pairs-config" .. "\nautocmd!"))
nvim.ex.autocmd("FileType", "clojure,fennel,scheme", ("call v:lua.require('" .. _2amodule_name_2a .. "').setup()"))
vim.cmd("augroup END")
return nil