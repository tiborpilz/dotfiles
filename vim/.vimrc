scriptencoding utf-8
set encoding=utf-8

set nocompatible
set shiftwidth=2 tabstop=2 expandtab
set wrap mouse=a
set dir=$HOME/.vim/tmp backupdir=$HOME/.vim/tmp
set ignorecase smartcase shiftround smartindent
set noerrorbells
set relativenumber
set autoread
" Statusbar
source $HOME/.vim/statusline.vim

" Plugin configs
" Look and feel
set fillchars+=vert:\ 

" Leader
let mapleader = ","

" Find command using rg and fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column ==line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "\!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" map <Leader>-n to nerdtree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

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

" emmet-vim config
" let g:user_emmet_mode='i'
" let g:user_emmet_leader_key='<Tab>'
" let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }

" ale config
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
" let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" let g:ale_set_baloons = 1
" let g:ale_sign_column_always = 1
" let g:airline#extensions#ale#enabled = 1

imap <C-Space <Plug>(ale_complete)
" Load plugins
source $HOME/.vim/bundle.vim

" Syntax Highlighting
syntax enable
set t_Co=256
" Color scheme
colorscheme wal

" silent! helptags ALL
