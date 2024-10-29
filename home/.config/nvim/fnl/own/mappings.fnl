(import-macros {: nmap
                : vmap
                : tmap
                : map
                : imap
                : autocmd
                : augroup} :own.macros)

(local {: autoload} (require :nfnl.module))

(local t (autoload :telescope.builtin))
(local error-filter {:severity vim.diagnostic.severity.ERROR})
(local warning-filter {:severity vim.diagnostic.severity.WARNING})

(fn opts [desc] {:silent true : desc})

(imap "jj" "<Esc>")

; Telescope
(nmap :<leader>ff ":lua require('telescope.builtin').find_files()<cr>")
(nmap :<leader>fg ":lua require('telescope.builtin').live_grep()<cr>")
(nmap :<leader>fo ":Telescope file_browser<cr>")
(nmap :<leader>fv ":lua require('telescope.builtin').git_files()<cr>")
(nmap :<leader>fb ":lua require('telescope.builtin').buffers()<cr>")
(nmap :<leader>fh ":lua require('telescope.builtin').help_tags()<cr>")

; LSP mappings
; Set only to the buffer where the LSP client is attached
(vim.api.nvim_create_augroup :eslint-autofix {:clear true})
; https://github.com/neovim/nvim-lspconfig/blob/da7461b596d70fa47b50bf3a7acfaef94c47727d/lua/lspconfig/server_configurations/eslint.lua#L141-L145
(fn set-eslint-autofix [bufnr]
  (autocmd :BufWritePre {:command :EslintFixAll
                         :group :eslint-autofix
                         :buffer bufnr}))
(fn buf-map [keymap callback desc]
  (nmap keymap callback {:buffer true
                         :silent true
                         : desc}))

(fn on-attach [args]
  (local bufnr args.buf)
  (local client (vim.lsp.get_client_by_id args.data.client_id))
  (vim.api.nvim_buf_set_option 0 :omnifunc :v:lua.vim.lsp.omnifunc)

  ;; Mappings
  (buf-map :K #(vim.lsp.buf.hover) "lsp: hover")
  (buf-map :gd #(vim.lsp.buf.definition {:reuse_win true}) "lsp: go to defintion")
  (buf-map :gr #(vim.lsp.buf.references) "lsp: references")
  (buf-map :gi #(vim.lsp.buf.implementation) "lsp: implementation")
  (buf-map :gs #(vim.lsp.buf.signature_help) "lsp: signature")
  (buf-map :gt #(vim.lsp.buf.type_definition) "lsp: type def")
  (buf-map :gq #(vim.lsp.diagnostic.set_loclist) "lsp: set loclist")
  (buf-map :ga #(vim.lsp.buf.code_action) "lsp: code actions")
  (vmap :gla #(vim.lsp.buf.code_action) {:buffer true
                                                :desc "lsp: code actions"})

  (when (= client.name :eslint) (set-eslint-autofix bufnr)))

(augroup :lsp-attach [:LspAttach {:callback on-attach}])

; Diagnostics
(nmap "[d" #(vim.diagnostic.goto_prev error-filter) (opts "next diagnostic"))
(nmap "]d" #(vim.diagnostic.goto_next error-filter) (opts "previous diagnostic"))
(nmap "[w" #(vim.diagnostic.goto_prev warning-filter) (opts "next warning"))
(nmap "]w" #(vim.diagnostic.goto_next warning-filter) (opts "previous warning"))
