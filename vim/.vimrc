" Basic stuff
set number			 					" Show line numbers
set cursorline						" Highlight current line

" Indetation & Tabs
set noexpandtab						" Use real tabs, not spaces 
set tabstop=2
set shiftwidth=2
set smartindent						" Autoindent new lines

" Seach behaviour
set ignorecase 						" Case-insenstive search...
set smartcase 						" ...unlles you type capital letters
set hlsearch							" Highlight matches

" Quality of Life
set clipboard=unnamedplus " Use system clipboard
"set mouse=a								" Enable mouse support
set wrap 									" Line wrapping on
set laststatus=2
set noerrorbells  				" Do not use beep error
set visualbell						" Flash screen on error
set backspace=indent,eol,start

" Appareance
syntax on 								" Enable syntax highlighting

" Performance
set updatetime=300				" Faster updates for plugins or linting

" =======================================
" 1. START of the vim-plug section
" =======================================
call plug#begin('~/.vim/plugged')

Plug 'rakr/vim-one'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"Plug 'altercation/vim-colors-solarized'
"Plug 'morhetz/gruvbox'


call plug#end()

" themes & colors

if $TERM ==# 'linux' || empty($DISPLAY)
    " Pure console: limited colors
    set notermguicolors
    set t_Co=16
    colorscheme desert
else
    " Terminal emulator
    if has("termguicolors")
        set termguicolors
    endif
		set background=light
		colorscheme one
endif
