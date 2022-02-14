(module magic.plugin.telescope
  {autoload {telescope telescope}
  require-macros [magic.macros]})

(telescope.load_extension :file_browser)

(nnoremap :<leader>ff ":lua require('telescope.builtin').find_files()<cr>")
(nnoremap :<leader>fg ":lua require('telescope.builtin').live_grep()<cr>")
(nnoremap :<leader>fo ":Telescope file_browser<cr>")
(nnoremap :<leader>fv ":lua require('telescope.builtin').git_files()<cr>")
(nnoremap :<leader>fb ":lua require('telescope.builtin').buffers()<cr>")
(nnoremap :<leader>fh ":lua require('telescope.builtin').help_tags()<cr>")
