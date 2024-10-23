(module magic.plugin.completion
  {autoload {nvim aniseed.nvim
             core aniseed.core
             cmp cmp
             ls luasnip
             l luasnip.extras.lambda
             r luasnip.extras.rep
             p luasnip.extras.partial
             m luasnip.extras.match
             n luasnip.extras.nonempty
             dl luasnip.extras.dynamic_lambda
             fmt luasnip.extras.fmt.fmt
             fmta luasnip.extras.fmt.fmta
             types luasnip.util.types
             conds luasnip.extras.expand_conditions
             from-vscode luasnip.loaders.from_vscode
             lspkind lspkind}})

;; load all the snippets defined by :rafamadriz/friendly-snippets
(from-vscode.load)

(set nvim.o.completeopt "menuone,noselect,preview")

(def- menu-sources {:path     "[path]"
                    :luasnip  "[snippet]"
                    :nvim_lsp "[lsp]"
                    :conjure  "[conjure]"
                    :buffer   "[buffer]"
                    :nvim_lua "[lua]"})

(cmp.setup {:mapping {:<Tab> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Select})
                      :<S-Tab> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Select})
                      :<down> (cmp.mapping.select_next_item {:behavior cmp.SelectBehavior.Select})
                      :<up> (cmp.mapping.select_prev_item {:behavior cmp.SelectBehavior.Select})
                      :<C-b> (cmp.mapping.scroll_docs (- 4))
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                  :select true})}
            :sources (cmp.config.sources [{:name :luasnip}
                                          {:name :nvim_lsp}
                                          {:name :conjure}
                                          {:name :buffer :keyword_length 5}])
            :formatting {:format (lspkind.cmp_format {:with_text false
                                                      :menu menu-sources})}
            :snippet {:expand (fn [args] (ls.lsp_expand args.body))}})


(vim.cmd "imap <silent><expr> <C-n> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-n>'")
(vim.cmd "inoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>")

(vim.cmd "snoremap <silent> <C-n> <cmd>lua require('luasnip').jump(1)<Cr>")
(vim.cmd "snoremap <silent> <C-p> <cmd>lua require('luasnip').jump(-1)<Cr>")

(vim.cmd "imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
(vim.cmd "smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
