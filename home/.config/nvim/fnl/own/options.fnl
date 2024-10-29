(import-macros {: autocmd} :own.macros)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(set vim.o.grepprg "ag -S --vimgrep")
(set vim.o.wildmode "full")
(set vim.o.wildoptions "pum")
(set vim.o.relativenumber true)
(set vim.o.number true)

; Warn if buffers were changed outside of vim
(autocmd :BufWinEnter {:pattern "*" :callback #(vim.cmd "checktime")})
(autocmd :WinEnter {:pattern "*" :callback #(vim.cmd "checktime")})
(autocmd :FocusGained {:pattern "*" :callback #(vim.cmd "checktime")})
(autocmd :CursorHold {:pattern "*" :callback #(vim.cmd "checktime")})

; Remove unnamedplus from clipboard
; This fails
; (vim.opt.clipboard (vim.tbl_filter (fn [item] (not= item "unnamedplus")) vim.opt.clipboard:get))
