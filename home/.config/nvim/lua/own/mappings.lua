-- [nfnl] Compiled from fnl/own/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local t = autoload("telescope.builtin")
local error_filter = {severity = vim.diagnostic.severity.ERROR}
local warning_filter = {severity = vim.diagnostic.severity.WARNING}
local function opts(desc)
  return {silent = true, desc = desc}
end
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>fv", ":lua require('telescope.builtin').git_files()<cr>")
vim.keymap.set("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>")
vim.api.nvim_create_augroup("eslint-autofix", {clear = true})
local function set_eslint_autofix(bufnr)
  return vim.api.nvim_create_autocmd("BufWritePre", {command = "EslintFixAll", group = "eslint-autofix", buffer = bufnr})
end
local function buf_map(keymap, callback, desc)
  return vim.keymap.set("n", keymap, callback, {buffer = true, silent = true, desc = desc})
end
local function on_attach(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local function _2_()
    return vim.lsp.buf.hover()
  end
  buf_map("K", _2_, "lsp: hover")
  local function _3_()
    return vim.lsp.buf.definition({reuse_win = true})
  end
  buf_map("gd", _3_, "lsp: go to defintion")
  local function _4_()
    return vim.lsp.buf.references()
  end
  buf_map("gr", _4_, "lsp: references")
  local function _5_()
    return vim.lsp.buf.definition({reuse_win = true})
  end
  buf_map("<leader>d", _5_, "lsp: go to defintion")
  local function _6_()
    return vim.lsp.buf.references()
  end
  buf_map("<leader>r", _6_, "lsp: references")
  local function _7_()
    return vim.lsp.buf.implementation()
  end
  buf_map("gi", _7_, "lsp: implementation")
  local function _8_()
    return vim.lsp.buf.signature_help()
  end
  buf_map("gs", _8_, "lsp: signature")
  local function _9_()
    return vim.lsp.buf.type_definition()
  end
  buf_map("gt", _9_, "lsp: type def")
  local function _10_()
    return vim.lsp.buf.code_action()
  end
  buf_map("ga", _10_, "lsp: code actions")
  local function _11_()
    return vim.lsp.buf.code_action()
  end
  vim.keymap.set("v", "gla", _11_, {buffer = true, desc = "lsp: code actions"})
  if (client.name == "eslint") then
    set_eslint_autofix(bufnr)
  else
  end
  return nil
end
do
  local group = vim.api.nvim_create_augroup("my-lsp-attach", {clear = true})
  vim.api.nvim_create_autocmd("LspAttach", {callback = on_attach, group = group})
end
local function _13_()
  return vim.diagnostic.goto_prev(error_filter)
end
vim.keymap.set("n", "[d", _13_, opts("next diagnostic"))
local function _14_()
  return vim.diagnostic.goto_next(error_filter)
end
vim.keymap.set("n", "]d", _14_, opts("previous diagnostic"))
local function _15_()
  return vim.diagnostic.goto_prev(warning_filter)
end
vim.keymap.set("n", "[w", _15_, opts("next warning"))
local function _16_()
  return vim.diagnostic.goto_next(warning_filter)
end
vim.keymap.set("n", "]w", _16_, opts("previous warning"))
local function _17_(opts0)
  local dir = (core.get(opts0, "args") or ".")
  local cmd = string.format("tmux new-window -c '%s' 'nvim' \\; select-window -t:last", dir)
  return vim.fn.system(cmd)
end
vim.api.nvim_create_user_command("OpenTmuxNvim", _17_, {nargs = "?"})
local function _18_()
  return vim.cmd("OpenTmuxNvim /Users/raja/.config/nvim")
end
vim.keymap.set("n", "<leader>c", _18_, opts("Open neovim config"))
local function _19_(opts0)
  local dir = (core.get(opts0, "args") or ".")
  local cmd = string.format("tmux new-window -c '%s' \\; select-window -t:last", dir)
  return vim.fn.system(cmd)
end
vim.api.nvim_create_user_command("OpenTmux", _19_, {nargs = "?"})
local function _20_()
  return vim.cmd("OpenTmux /Users/raja/.config/nvim")
end
return vim.keymap.set("n", "<leader>cd", _20_, opts("Open neovim config directory"))
