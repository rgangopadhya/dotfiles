-- [nfnl] Compiled from fnl/own/options.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.grepprg = "ag -S --vimgrep"
vim.o.wildmode = "full"
vim.o.wildoptions = "pum"
vim.o.relativenumber = true
vim.o.number = true
local function _1_()
  return vim.cmd("checktime")
end
vim.api.nvim_create_autocmd("BufWinEnter", {pattern = "*", callback = _1_})
local function _2_()
  return vim.cmd("checktime")
end
vim.api.nvim_create_autocmd("WinEnter", {pattern = "*", callback = _2_})
local function _3_()
  return vim.cmd("checktime")
end
vim.api.nvim_create_autocmd("FocusGained", {pattern = "*", callback = _3_})
local function _4_()
  return vim.cmd("checktime")
end
vim.api.nvim_create_autocmd("CursorHold", {pattern = "*", callback = _4_})
vim.o.completeopt = "menuone,noselect,preview"
return nil
