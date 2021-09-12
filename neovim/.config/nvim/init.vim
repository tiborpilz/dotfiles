" call plug#begin('~/.config/nvim/plugged')
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" 
" Plug 'ryanoasis/vim-devicons'
" Plug 'preservim/nerdtree'
" 
" Plug 'hoob3rt/lualine.nvim'
" 
" call plug#end()
scriptencoding utf-8
set encoding=utf-8
" let base16colorpsace=256
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
set nofoldenable

"" Smoother update
set updatetime=1000

" Leader
let mapleader = ","

" Load plugins
source $HOME/.config/nvim/plugins.vim

" Look and Feel
source $HOME/.config/nvim/look-and-feel.vim
set signcolumn=yes:1
highlight clear SignColumn
set fillchars=eob:\ 
