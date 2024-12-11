-- [nfnl] Compiled from fnl/own/options.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.grepprg = "ag -S --vimgrep"
vim.o.wildmode = "full"
vim.o.wildoptions = "pum"
vim.o.relativenumber = true
vim.o.number = true
local function checktime()
  vim.cmd("checktime")
  return nil
end
vim.api.nvim_create_autocmd("BufWinEnter", {pattern = "*", callback = checktime})
vim.api.nvim_create_autocmd("WinEnter", {pattern = "*", callback = checktime})
vim.api.nvim_create_autocmd("FocusGained", {pattern = "*", callback = checktime})
vim.api.nvim_create_autocmd("CursorHold", {pattern = "*", callback = checktime})
vim.o.completeopt = "menuone,noselect,preview"
return nil
