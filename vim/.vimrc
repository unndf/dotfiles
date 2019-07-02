" turn on syntax highlighting
syntax enable

"Line Numbers
set number relativenumber
set ruler

"colorscheme settings
set background=dark
colorscheme molokai

"let g:airline_theme='laederon'
let g:airline_powerline_fonts=1
set laststatus=2 "For vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1 "use fugitive for git branches on airline

"use utf8
set encoding=utf8

"replace tabs with spaces
set expandtab

"tab = 4 spaces
set shiftwidth=4
set tabstop=4

"autoindent and filetype indent
set ai
filetype plugin indent on

"cursor style to highlight line and column
set cursorline
set cursorcolumn

set nocompatible
filetype on

"allow buffers to be hidden without writing
set hidden

" keybinds

"quick buffer switching
:nnoremap <C-n> :bn<Enter>
:nnoremap <C-p> :bp<Enter>

"enable mouse
:set mouse=a

" Set search highlight on
set hlsearch

" Syntastic Kotlin enable
" Breaks with gradle/maven/ant
"let g:syntastic_kotlin_checkers=['kotlinc']

" ultisnips settings

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" java omnicompletion
autocmd FileType java :packadd vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
