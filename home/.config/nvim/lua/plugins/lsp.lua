-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("lspconfig.util")
local cmp_lsp = autoload("cmp_nvim_lsp")
local schema_store = autoload("schemastore")
local lspconfig = autoload("lspconfig")
local mason = autoload("mason")
local mason_lspconfig = autoload("mason-lspconfig")
local function mason_config()
  return mason.setup()
end
local function ruby_lsps()
  lspconfig.solargraph.setup({root_dir = util.root_pattern(".git"), cmd = {"bundle", "exec", "solargraph", "stdio"}})
  local function _2_()
    return vim.lsp.buf.format()
  end
  return vim.api.nvim_create_autocmd("BufWritePre", {pattern = "*.rb", callback = _2_})
end
local function lsp_config()
  local git_root = util.root_pattern(".git")
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local base_settings = {capabilities = cmp_lsp.default_capabilities(client_capabilities), init_options = {preferences = {includeCompletionsWithSnippetText = true, includeCompletionsForImportStatements = true}}}
  local server_configs = {jsonls = {settings = {json = {schemas = schema_store.json.schemas(), validate = {enable = true}}}}, lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}, diagnostics = {globals = {"vim", "it", "describe", "before_each", "after_each", "pending"}}, format = {enable = false}, workspace = {checkThirdParty = false}}}}, eslint = {root_dir = git_root}, pylsp = {plugins = {flake8 = {maxLineLength = "100"}}}, fennel_language_server = {single_file_support = true, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {diagnostics = {globals = {"vim", "jit", "comment"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}, cssls = {root_dir = git_root}, shellcheck = {root_dir = git_root}}
  for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
    local server_setup = core["get-in"](lspconfig, {server_name, "setup"})
    local server_config = core.get(server_configs, server_name, {})
    if (server_name == "gopls") then
      server_setup(server_config)
    else
      server_setup(core.merge(base_settings, server_config))
    end
  end
  return ruby_lsps()
end
return {{"nvimtools/none-ls.nvim", dependencies = {"nvim-lua/plenary.nvim"}}, {"williamboman/mason.nvim", config = mason_config}, {"williamboman/mason-lspconfig.nvim", dependencies = {"williamboman/mason.nvim"}, opts = {ensure_installed = {"bashls", "cssls", "jedi_language_server", "jsonls", "lua_ls", "eslint", "fennel_language_server", "ruff", "solargraph", "rust_analyzer"}}, config = true}, {"pmizio/typescript-tools.nvim", dependencies = {"neovim/nvim-lspconfig", "nvim-lua/plenary.nvim"}, opts = {}}, {"neovim/nvim-lspconfig", dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp", "folke/lazydev.nvim", "nvim-lua/lsp-status.nvim", "onsails/lspkind-nvim", "nvimtools/none-ls.nvim", "b0o/SchemaStore.nvim"}, config = lsp_config}, "folke/lazydev.nvim"}
