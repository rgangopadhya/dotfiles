syntax enable
filetype plugin indent on

execute pathogen#infect()

set termguicolors
colorscheme NeoSolarized
set background=dark

:imap <S-Space> <Esc>
:imap jj <Esc>

set diffexpr=

"highlight search matches
set hlsearch

"show line numbers
set number

"windows-specific bs - fix backspace
set backspace=2
set backspace=indent,eol,start

"make tab set of spaces - insert 2
set tabstop=4
set expandtab
"same for those inserted for indentation
set shiftwidth=4

"search for visually selected text using //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

"open nerdtree with <F6>
nmap <F6> :NERDTreeToggle<CR>

"close terminal mode w ESC
tnoremap <Esc> <C-\><C-n>

"ctrl-p ignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv\|mypy_cache\|\.terraform\|.pyc\|approvals\|flow-typed-overrides'
"no max files
let g:ctrlp_max_files = 0
"show hidden files
let g:ctrlp_show_hidden = 1

"fuzzy-file-finder installed with homebrew
set rtp+=/usr/local/opt/fzf

"call vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'galooshi/vim-import-js'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'flowtype/vim-flow', {
  \ 'autoload': {
  \     'filetypes': 'javascript'
  \ }}
Plug 'w0rp/ale'
Plug 'hashivim/vim-terraform'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ambv/black'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()

" run code completion at startup
let g:python3_host_prog = '/Users/raja/.pyenv/versions/py3neovim/bin/python'
let g:python_host_prog = '/Users/raja/.pyenv/versions/py2neovim/bin/python'
let g:deoplete#enable_at_startup = 1

" configure prettier to run on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

autocmd BufWritePre *.py execute ':Black'

" run terraform fmt on save
let g:terraform_fmt_on_save=1

" match .eslintrc's prettier rules
let g:prettier#config#config_precedence = 'file-override'
let g:prettier#config#print_width = 100
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#parser = 'flow'

"automatically load in changes from outside vim
set autoread
autocmd FocusGained * checktime

