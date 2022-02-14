(module own.plugin.lsp
  {autoload {nvim aniseed.nvim
             a aniseed.core
             install lspinstall
             config lspconfig
             installer nvim-lsp-installer
             servers nvim-lsp-installer.servers
             status lsp-status
             lua-dev lua-dev
             cmp-lsp cmp_nvim_lsp
             kind lspkind
             Input nui.input
             Menu nui.menu}
   require-macros [magic.macros]})

(kind.init)

(let [command! nvim.ex.command!]
  (command! :MyLspFix "lua vim.lsp.buf.formatting_sync()"))

(defn- on-attach [client bufnr]
  (status.config {:indicator_separator ::
                  :indicator_errors :e
                  :indicator_warnings :w
                  :indicator_hint :h
                  :indicator_info :i})
  (status.register_progress)
  (status.on_attach client)

  (buf_set_option bufnr :omnifunc :v:lua.vim.lsp.omnifunc)
  (buf_set_var bufnr :lsp_client_name client.name)
  (nvim.ex.autocmd :BufWritePre :<buffer> :MyLspFix)
  (augroup format-on-save 
    (nvim.ex.autocmd! "*" :<buffer>)
    (nvim.ex.autocmd :BufWritePre :<buffer> :MyLspFix))
  ;; (when (= client.name :eslint)
  ;;   (nvim.ex.autocmd :BufWritePre :<buffer> :EslintFixAll))

  ;; Mappings
  (nnoremap :K ":lua vim.lsp.buf.hover()<cr>" :buffer :silent)
  (nnoremap :gd ":lua vim.lsp.buf.definition()<cr>" :buffer :silent)
  (nnoremap :gr ":lua vim.lsp.buf.references()<cr>" :buffer :silent)
  (nnoremap :gc ":lua vim.lsp.buf.implementation()<cr>" :buffer :silent)
  (nnoremap :gs ":lua vim.lsp.buf.signature_help()<cr>" :buffer :silent)
  (nnoremap :gt ":lua vim.lsp.buf.type_definition()<cr>" :buffer :silent)
  (nnoremap :gq ":lua vim.lsp.diagnostic.set_loclist()<cr>" :buffer :silent)
  (nnoremap :ga ":Telescope lsp_code_actions theme=get_cursor<cr>" :buffer :silent)
  (nnoremap "[d"   ":lua vim.lsp.diagnostic.goto_prev()<cr>" :buffer :silent)
  (nnoremap "]d"   ":lua vim.lsp.diagnostic.goto_next()<cr>" :buffer :silent))

(def- lsp-settings {:on_attach on-attach
                    :capabilities (cmp-lsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :settings {:Lua (a.get-in (lua-dev.setup) [:settings :Lua])}
                    :init_options {:preferences {:includeCompletionsWithSnippetText true
                                                 :includeCompletionsForImportStatements true}}})

(installer.on_server_ready
  (fn [server] (server:setup lsp-settings)))

(let [required-servers [:cssls
                        :eslint
                        :gopls
                        :jsonls
                        :pylsp
                        :solargraph
                        :sumneko_lua
                        :terraform-ls
                        :tsserver
                        :vimls]]
  (each [_ server-name (ipairs required-servers)]
    (let [(available server) (servers.get_server server-name)]
     (when (and available (not (server:is_installed)))
        (installer.install server-name)))))
