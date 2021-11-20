local _2afile_2a = ".config/nvim/fnl/magic/plugin.fnl"
local _2amodule_name_2a = "magic.plugin"
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
local a, packer = autoload("aniseed.core"), autoload("packer")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["packer"] = packer
local function safe_require_plugin_config(name)
  local ok_3f, val_or_err = pcall(require, ("magic.plugin." .. name))
  if not ok_3f then
    return print(("Plugin config error: " .. val_or_err))
  else
    return nil
  end
end
_2amodule_locals_2a["safe-require-plugin-config"] = safe_require_plugin_config
local function req(name)
  return ("require('magic.plugin." .. name .. "')")
end
_2amodule_2a["req"] = req
local function use(...)
  do
    local pkgs = {...}
    local function _2_(use0)
      for i = 1, a.count(pkgs), 2 do
        local name = pkgs[i]
        local opts = pkgs[(i + 1)]
        do
          local _3_ = opts.mod
          if (nil ~= _3_) then
            safe_require_plugin_config(_3_)
          else
          end
        end
        use0(a.assoc(opts, 1, name))
      end
      return nil
    end
    packer.startup(_2_)
  end
  return nil
end
_2amodule_2a["use"] = use