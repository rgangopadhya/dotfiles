-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
require("own.bootstrap")
require("own.options")
require("config.lazy")
local function _1_()
  return require("own.mappings")
end
return vim.schedule(_1_)
