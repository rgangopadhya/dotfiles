(import-macros {: map : use} :own.macros)
(local {: autoload} (require :nfnl.module))
(local cmp (autoload :cmp))
(local ls (autoload :luasnip))
(local lspkind (autoload :lspkind))

;; This explodes on me. I think there is an issue with order of loading..?
;; ((. (require :luasnip.loaders.from_vscode) :lazy_load))
(set vim.o.completeopt "menuone,noselect,preview")

(fn config [] 
  (local menu-sources {:path     "[path]"
                    :luasnip  "[snippet]"
                    :nvim_lsp "[lsp]"
                    :conjure  "[conjure]"
                    :buffer   "[buffer]"
                    :nvim_lua "[lua]"})
  (local cmd-mappings {:<Tab> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Select})
                      :<S-Tab> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Select})
                      :<down> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Select})
                      :<up> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Select})
                      :<C-b> (cmp.mapping.scroll_docs (- 4))
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                  :select true})})
  (cmp.setup {:mapping (cmp.mapping.preset.insert cmd-mappings)
            :sources (cmp.config.sources [{:name :luasnip}
                                          {:name :nvim_lsp}
                                          {:name :conjure}
                                          {:name :buffer :keyword_length 5}])
            :formatting {:format (lspkind.cmp_format {:with_text false
                                                      :menu menu-sources})}
            :snippet {:expand (fn [args] (ls.lsp_expand args.body))}
  })
  (cmp.setup.cmdline {:mapping (cmp.mapping.preset.cmdline cmd-mappings)})
  (ls.config.setup {:history true
                  :update_events "TextChanged,TextChangedI"
                  :enable_autosnippets true})
)

[
  (use :hrsh7th/nvim-cmp {:dependencies [
              ; nvim-cmp source for nvim's lsp client
              :hrsh7th/cmp-nvim-lsp
              ; nvim-cmp source for buffer words
              :hrsh7th/cmp-buffer
              :L3MON4D3/LuaSnip
              ; nvim-cmp source for LuaSnip
              :saadparwaiz1/cmp_luasnip
              ; Community configured snippets for a bunch of languages
              :rafamadriz/friendly-snippets
              ]
     :event :InsertEnter
     : config
  })
  (use :L3MON4D3/LuaSnip {:dependencies [:rafamadriz/friendly-snippets]})
]
