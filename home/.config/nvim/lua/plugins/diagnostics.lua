-- [nfnl] Compiled from fnl/plugins/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local null_ls = autoload("null-ls")
local u = autoload("null-ls.utils")
local cfg = autoload("own.config")
local function root_pattern(pattern)
  local function _3_(_2_)
    local bufname = _2_["bufname"]
    local root_fn = u.root_pattern(pattern)
    return root_fn(vim.fn.expand(bufname))
  end
  return _3_
end
local function with_root_file(...)
  local files = {...}
  local function _4_(utils)
    return utils.root_has_file(files)
  end
  return _4_
end
local function get_source_name(diagnostic)
  local or_5_ = diagnostic.source
  if not or_5_ then
    local tmp_3_auto = diagnostic.namespace
    if (nil ~= tmp_3_auto) then
      local tmp_3_auto0 = vim.diagnostic.get_namespace(tmp_3_auto)
      if (nil ~= tmp_3_auto0) then
        or_5_ = tmp_3_auto0.name
      else
        or_5_ = nil
      end
    else
      or_5_ = nil
    end
  end
  return (or_5_ or ("ns:" .. tostring(diagnostic.namespace)))
end
local function diagnostic_format(diagnostic)
  return (cfg.icons[diagnostic.severity] .. " [" .. get_source_name(diagnostic) .. "] " .. diagnostic.message)
end
vim.diagnostic.config({underline = true, virtual_text = true, severity_sort = true, float = {header = "", border = cfg.border, format = diagnostic_format}, signs = false, update_in_insert = false})
vim.api.nvim_create_augroup("lsp-formatting", {clear = true})
local function on_attach(client, bufnr)
  print(("diagnostics attaching" .. bufnr))
  if client.supports_method("textDocument/formatting") then
    local function _10_()
      return vim.lsp.buf.format({bufnr = bufnr})
    end
    return vim.api.nvim_create_autocmd("BufWritePre", {buffer = bufnr, callback = _10_, group = "lsp-formatting"})
  else
    return nil
  end
end
local function config()
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  return null_ls.setup({sources = {diagnostics.selene.with({cwd = root_pattern("selene.toml"), condition = with_root_file("selene.toml")}), diagnostics.pylint.with({cwd = root_pattern("requirements-dev.txt"), condition = with_root_file("venv/bin/pylint"), prefer_local = "venv/bin", args = {"--from-stdin", "$FILENAME", "-f", "json", "-d", "line-too-long,missing-function-docstring"}}), formatting.gofmt, formatting.sqlfluff.with({prefer_local = "node_modules/.bin"}), formatting.stylua, formatting.terraform_fmt}, on_attach = on_attach})
end
return {"nvimtools/none-ls.nvim", dependencies = {"nvim-lua/plenary.nvim"}, config = config}
