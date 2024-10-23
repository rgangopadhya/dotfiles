(module magic.plugin.better-default
  {autoload {nvim aniseed.nvim}
   require-macros [magic.macros]})

(set nvim.g.vim_better_default_persistent_undo true)
(nvim.ex.runtime_ "plugin/default.vim")

(nvim.ex.set :wrap)
(nvim.ex.set "wildmode=full")
(nvim.ex.set "wildoptions=pum")
(nvim.ex.set "listchars-=eol:↵")
(nvim.ex.set :norelativenumber)
(nvim.ex.set :number)

(nvim.ex.autocmd :BufWinEnter "*" :checktime)
(nvim.ex.autocmd :WinEnter "*" :checktime)
(nvim.ex.autocmd :FocusGained "*" :checktime)
(nvim.ex.autocmd :CursorHold "*" :checktime)

(set nvim.o.undodir (.. (nvim.fn.stdpath "data") "/undo"))

(nvim.ex.set "clipboard-=unnamedplus")
(nnoremap :<leader>gg ":LazyGit<cr>")
