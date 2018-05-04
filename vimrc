set nocompatible

set shiftwidth=2 tabstop=2 noexpandtab
set wrap mouse=a
set dir=~/.vim/tmp backupdir=~/.vim/tmp
set ignorecase smartcase shiftround smartindent
set t_Co=256
set autochdir
set noerrorbells
set vb t_vb=""

" Plugins specific configs
source ~/.vim/bundle.vim

" Syntax Highlighting
syntax enable

" Color scheme
set background=dark
silent! colorscheme wal
let base16colorspace=256

" Leader
let mapleader = ","

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" map <Leader>-n to nerdtree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Fix Python indentation.
autocmd FileType python setlocal shiftwidth=2 tabstop=2

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Don't remap '#' to avoid smartindent problem
:inoremap # X<BS>#

set number
set noswapfile

set laststatus=2

" Use LaTeX rather than plain TeX.
let g:tex_flavor = "latex"

" Airline font population
let g:airline_powerline_fonts = 1
