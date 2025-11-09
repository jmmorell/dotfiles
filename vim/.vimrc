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
set mouse=a								" Enable mouse support
set wrap 									" Line wrapping on
set laststatus=2
set noerrorbells  				" Do not use beep error
set visualbell						" Flash screen on error
set backspace=indent,eol,start

" Appareance
syntax on 								" Enable syntax highlighting
set background=light
colorscheme desert
set termguicolors					" Enable 24-bit colors

" Performance
set updatetime=300				" Faster updates for plugins or linting
