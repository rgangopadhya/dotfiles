(module own.plugin.diagnostics
  {autoload {nvim aniseed.nvim
             null-ls null-ls
             u null-ls.utils}
   require-macros [magic.macros]})

(vim.diagnostic.config {:underline true
                        :virtual_text true
                        :signs true
                        :update_in_insert true
                        :severity_sort true})

(null-ls.setup
  {:sources [null-ls.builtins.code_actions.eslint_d
             null-ls.builtins.diagnostics.eslint_d
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
                                                                    :typescriptreact]})]})

(defn eslint-fix []
  (vim.cmd "silent !npx eslint_d --fix %")
  (vim.cmd :edit))

(defn rubocop-fix []
  (vim.cmd "silent !bundle exec rubocop -A %")
  (vim.cmd :edit))

(augroup fix-on-save
  (nvim.ex.autocmd :BufWritePost "*.ts,*.tsx" (viml->fn :eslint-fix))
  (nvim.ex.autocmd :BufWritePost "*.rb" (viml->fn :rubocop-fix)))
