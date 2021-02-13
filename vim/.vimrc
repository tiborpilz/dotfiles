scriptencoding utf-8
set encoding=utf-8
let base16colorpsace=256

"" Basic Settings
set nocompatible
set shiftwidth=2 tabstop=2 expandtab
set wrap mouse=a
set dir=$HOME/.vim/tmp backupdir=$HOME/.vim/tmp
set ignorecase smartcase shiftround smartindent
set noerrorbells
set relativenumber
set autoread
set modeline
set modelines=5

" Leader
let mapleader = ","

" Load plugins
source $HOME/.vim/plugins.vim

" Load language-specific config
source $HOME/.vim/languages/*

" Load Color Scheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Look and feel
set fillchars+=vert:│

set laststatus=2

" Airline font population
" let g:airline_powerline_fonts = 0


" Syntax Highlighting
syntax enable
set t_Co=256

" Color scheme
colorscheme base16-default-dark
