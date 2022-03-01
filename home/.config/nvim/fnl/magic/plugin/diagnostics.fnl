(module own.plugin.diagnostics
  {autoload {nvim aniseed.nvim
             a aniseed.core
             null-ls null-ls
             u null-ls.utils}
   require-macros [magic.macros]})

(vim.diagnostic.config {:underline true
                        :virtual_text true
                        :signs true
                        :update_in_insert true
                        :severity_sort true})

(let [command! nvim.ex.command!]
  (command! :MyLspFix "lua vim.lsp.buf.formatting_sync(nil, 5000)"))

(defn- on-attach-null [client]
    (nvim.ex.autocmd :BufWritePre :<buffer> :MyLspFix))

(null-ls.setup
  {:sources [null-ls.builtins.code_actions.eslint_d
             null-ls.builtins.diagnostics.eslint_d
             (null_ls.builtins.formatting.gofmt.with {:cwd project-root :root_dir git-root})
             (null_ls.builtins.formatting.goimports.with {:cwd project-root :root_dir git-root})
             (null_ls.builtins.formatting.black.with {:cwd project-root :root_dir git-root :args [:--quiet :--line-lenth :100 :--fast :-]})
             (null_ls.builtins.formatting.isort.with {:args [:--dont-float-to-top :-l :100 :--skip-gitignore :--dont-order-by-type :--stdout :--profile :black :-]})
             (null-ls.builtins.diagnostics.rubocop.with {:cwd project-root
                                                         :root_dir git-root
                                                         :command :bundle
                                                         :args [:exec :rubocop :-f :json :--stdin :$FILENAME]})
             (null-ls.builtins.diagnostics.cspell.with {:cwd project-root
                                                        :root_dir git-root
                                                        :prefer_local :node_modules/.bin
                                                        :filetypes [:fennel
                                                                    :go
                                                                    :javascript
                                                                    :json
                                                                    :markdown
                                                                    :ruby
                                                                    :sql
                                                                    :typescript
                                                                    :typescriptreact]})]
   :on_attach on-attach-null})

(defn eslint-fix []
  (vim.cmd "silent !npx eslint_d --fix %")
  (vim.cmd :edit))

(defn rubocop-fix []
  (vim.cmd "silent !bundle exec rubocop -A %")
  (vim.cmd :edit))

(augroup fix-on-save
  (nvim.ex.autocmd :BufWritePost "*.ts,*.tsx" (viml->fn :eslint-fix))
  (nvim.ex.autocmd :BufWritePost "*.rb" (viml->fn :rubocop-fix)))
