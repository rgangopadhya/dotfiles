(import-macros {: use : autocmd} :own.macros)
(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :lspconfig.util))
(local cmp-lsp (autoload :cmp_nvim_lsp))
(local schema-store (autoload :schemastore))
(local lspconfig (autoload :lspconfig))
(local mason (autoload :mason))
(local mason-lspconfig (autoload :mason-lspconfig))

(fn mason-config []
  (mason.setup))

(fn ruby-lsps []
  (lspconfig.solargraph.setup {:root_dir (util.root_pattern :.git)
                               :cmd [:bundle :exec :solargraph :stdio]})

  ; format on save with rubocop through solargraph
  (autocmd :BufWritePre {:pattern :*.rb
                         :callback #(vim.lsp.buf.format)}))

(fn lsp-config []
  (local git-root (util.root_pattern :.git))

  (local client-capabilities (vim.lsp.protocol.make_client_capabilities))

  (local base-settings {:capabilities (cmp-lsp.default_capabilities client-capabilities)
                        :init_options {:preferences {:includeCompletionsWithSnippetText true
                                                     :includeCompletionsForImportStatements true}}})


  (local server-configs {:jsonls {:settings {:json {:schemas (schema-store.json.schemas)
                                                    :validate {:enable true}}}}
                         :lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}
                                                   :diagnostics {:globals [:vim
                                                                           :it
                                                                           :describe
                                                                           :before_each
                                                                           :after_each
                                                                           :pending]}
                                                   :format {:enable false}
                                                   :workspace {:checkThirdParty false}}}}
                         :eslint {:root_dir git-root}
                         :pylsp {:plugins {:flake8 { :maxLineLength :100}}}
                         :fennel_language_server {:single_file_support true
                                                  :root_dir (lspconfig.util.root_pattern :fnl)
                                                  :settings {:fennel {:diagnostics {:globals [:vim :jit :comment]}
                                                                      :workspace {:library (vim.api.nvim_list_runtime_paths)}}}}
                         :cssls {:root_dir git-root}
                         :shellcheck {:root_dir git-root}})

  (each [_ server-name (ipairs (mason-lspconfig.get_installed_servers))]
    (let [server-setup (core.get-in lspconfig [server-name :setup])
          server-config (core.get server-configs server-name {})]
      (if (= server-name :gopls)
          (server-setup server-config)
          (server-setup (core.merge base-settings server-config)))))

  (ruby-lsps))

[
 ; Gives a hook into LSP client for non-LSP sources
 (use :nvimtools/none-ls.nvim { :dependencies [ :nvim-lua/plenary.nvim ] })
 ; The latest way to add non-LSP sources
 (use :williamboman/mason.nvim { :config mason-config })
 (use :williamboman/mason-lspconfig.nvim { :dependencies [:williamboman/mason.nvim]
      :opts {:ensure_installed [
				:bashls
				:cssls
				:jedi_language_server
				:jsonls
				:lua_ls
				:eslint
				:fennel_language_server
				:ruff
				:solargraph
				:rust_analyzer
	]} :config true})
 (use :pmizio/typescript-tools.nvim {:dependencies [:neovim/nvim-lspconfig
                                                    :nvim-lua/plenary.nvim]
                                     :opts {}})
 (use :neovim/nvim-lspconfig { :dependencies [
				:williamboman/mason.nvim
				:williamboman/mason-lspconfig.nvim
				:hrsh7th/cmp-nvim-lsp
				:folke/lazydev.nvim
				; Diagnostics
				:nvim-lua/lsp-status.nvim
				; vscode-like pictograms
				:onsails/lspkind-nvim
				:nvimtools/none-ls.nvim
                                :b0o/SchemaStore.nvim
			] :config lsp-config })
 ; LuaLS
 (use :folke/lazydev.nvim)
 ]
