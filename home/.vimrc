syntax enable
filetype plugin indent on

set termguicolors
colorscheme NeoSolarized
set background=dark

" customize leader from \ to ,
let mapleader=","
vnoremap <Leader>a y:Ag <C-r>=fnameescape(@")<CR><CR>

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
set tabstop=2
set expandtab
"same for those inserted for indentation
set shiftwidth=2

"search for visually selected text using //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

"open nerdtree with <F6>
nmap <F6> :NERDTreeToggle<CR>

"close terminal mode w ESC
tnoremap <Esc> <C-\><C-n>

"ctrl-p ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv\|mypy_cache\|\.terraform\|.pyc\|approvals\|flow-typed-overrides\|tmp\|fixtures\|.gz\|.map\|.zip'
"no max files
let g:ctrlp_max_files = 0
"show hidden files
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"fuzzy-file-finder installed with homebrew
set rtp+=/usr/local/opt/fzf

"call vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'overcache/NeoSolarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'sjl/vitality.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
call plug#end()

" run code completion at startup
let g:python3_host_prog = '/Users/raja/.pyenv/versions/py3neovim/bin/python'
let g:python_host_prog = '/Users/raja/.pyenv/versions/py2neovim/bin/python'
let g:deoplete#enable_at_startup = 1

" configure prettier to run on save
let g:prettier#autoformat = 0

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
autocmd CursorHold * checktime
autocmd WinEnter * checktime
autocmd BufWinEnter * checktime

" set python tabbing
autocmd FileType pythono setlocal expandtab shiftwidth=4 tabstop=4

" Clipboard 
set clipboard=unnamed

" Tab navigation like Firefox.
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Conquer of Completion
let g:coc_global_extensions = ['coc-eslint', 'coc-json', 'coc-tsserver', 'coc-python', 'coc-solargraph', 'coc-diagnostic']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Ale config
let g:ale_fixers = {
      \  'javascript': ['eslint_d', 'prettier'],
      \   'css': ['prettier'],
      \   'python': ['black'],
      \}
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_python_black_options = '-l 100'
