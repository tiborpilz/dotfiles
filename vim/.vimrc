
scriptencoding utf-8
set encoding=utf-8

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

" Statusbar
source $HOME/.vim/statusline.vim

" Plugin configs
" Look and feel
set fillchars+=vert:\ 

" Leader
let mapleader = ","

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" CTRL+P
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" Vimtex
let g:vimtex_view_method = 'zathura'

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Don't remap '#' to avoid smartindent problem
:inoremap # X<BS>#

set laststatus=2

" Use LaTeX rather than plain TeX.
let g:tex_flavor = "latex"

" Airline font population
let g:airline_powerline_fonts = 0


" autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
" emmet-vim config
" let g:user_emmet_mode='i'
" let g:user_emmet_leader_key='<Tab>'
" let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

imap <C-Space <Plug>(ale_complete)
" Load plugins
source $HOME/.vim/bundle.vim

" Syntax Highlighting
syntax enable
set t_Co=256

map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" Color scheme
colorscheme wal
