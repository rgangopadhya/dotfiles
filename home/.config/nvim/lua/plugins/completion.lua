-- [nfnl] Compiled from fnl/plugins/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local cmp = autoload("cmp")
local ls = autoload("luasnip")
local lspkind = autoload("lspkind")
local function config()
  local menu_sources = {path = "[path]", luasnip = "[snippet]", nvim_lsp = "[lsp]", conjure = "[conjure]", buffer = "[buffer]", nvim_lua = "[lua]"}
  local cmd_mappings = {["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), ["<down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), ["<up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.close(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})}
  local function _2_(args)
    return ls.lsp_expand(args.body)
  end
  cmp.setup({mapping = cmp.mapping.preset.insert(cmd_mappings), sources = cmp.config.sources({{name = "luasnip"}, {name = "nvim_lsp"}, {name = "conjure"}, {name = "buffer", keyword_length = 5}}), formatting = {format = lspkind.cmp_format({menu = menu_sources, with_text = false})}, snippet = {expand = _2_}})
  cmp.setup.cmdline({mapping = cmp.mapping.preset.cmdline(cmd_mappings)})
  ls.config.setup({history = true, update_events = "TextChanged,TextChangedI", enable_autosnippets = true})
  return require("luasnip.loaders.from_vscode").lazy_load()
end
return {{"hrsh7th/nvim-cmp", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets"}, event = "InsertEnter", config = config}, {"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}}}
