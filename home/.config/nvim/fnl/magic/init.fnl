(module magic.init
  {autoload {plugin magic.plugin
             nvim aniseed.nvim}})

;;; Introduction

;; Aniseed compiles this (and all other Fennel files under fnl) into the lua
;; directory. The init.lua file is configured to load this file when ready.

;; We'll use modules, macros and functions to define our configuration and
;; required plugins. We can use Aniseed to evaluate code as we edit it or just
;; restart Neovim.

;; You can learn all about Conjure and how to evaluate things by executing
;; :ConjureSchool in your Neovim. This will launch an interactive tutorial.


;;; Generic configuration

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)

(nvim.ex.set :spell)
(nvim.ex.set :list)

(set nvim.o.grepprg "rg -S --vimgrep")

;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")


;;; Plugins

;; Run script/sync.sh to update, install and clean your plugins.
;; Packer configuration format: https://github.com/wbthomason/packer.nvim
(plugin.use
  :Olical/aniseed {}
  :Olical/conjure {}
  :PeterRincker/vim-argumentative {}
  :airblade/vim-gitgutter {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :easymotion/vim-easymotion {}
  :folke/which-key.nvim {}
  :guns/vim-sexp {}
  :hrsh7th/nvim-compe {}
  :itchyny/lightline.vim {}
  :jiangmiao/auto-pairs {:mod :auto-pairs}
  :junegunn/fzf { :run "./install --all" }
  :junegunn/fzf.vim {}
  :liuchengxu/vim-better-default {:mod :better-default}
  :mbbill/undotree {}
  :nvim-telescope/telescope.nvim { :requires [:nvim-lua/plenary.nvim :nvim-lua/popup.nvim] :mod :telescope }

  ;; LSP
  :neovim/nvim-lspconfig {:requires [:kabouzeid/nvim-lspinstall
                                   :folke/lua-dev.nvim
                                   :nvim-lua/lsp-status.nvim
                                   :onsails/lspkind-nvim
                                   :MunifTanjim/nui.nvim]
                        :rocks :json-lua
                        :mod :lsp}

  ;; Completion
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :PaterJason/cmp-conjure
                                :L3MON4D3/LuaSnip
                                :saadparwaiz1/cmp_luasnip]
                     :mod :completion}
  :radenling/vim-dispatch-neovim {}
  :srcery-colors/srcery-vim {:mod :srcery}
  :tami5/compe-conjure {}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :w0rp/ale {:mod :ale}
  :wbthomason/packer.nvim {}
  :icymind/neosolarized {}
  )
