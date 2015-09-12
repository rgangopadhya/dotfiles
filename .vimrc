syntax enable
filetype plugin indent on

set background=dark
colorscheme solarized

:imap <S-Space> <Esc>
:imap jj <Esc>

:set diffexpr=

"highlight search matches
:set hlsearch

"show line numbers
:set number

"windows-specific bs - fix backspace
set backspace=2
set backspace=indent,eol,start

"make tab set of spaces - insert 2
:set tabstop=4
"same for those inserted for indentation
:set shiftwidth=4
