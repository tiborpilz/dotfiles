set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" colorschemes
" Plug 'dylanaraps/wal.vim' " custom color scheme from pywal
Plug 'chriskempson/base16-vim'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" icons
Plug 'ryanoasis/vim-devicons'

" general syntax highlighting / linting / autocomplete
" Plug 'dense-analysis/ale'
" let g:ale_sign_column_always = 1
" let g:airline#extensions#ale#enabled = 1

Plug 'honza/dockerfile.vim'
Plug 'tpope/vim-markdown'

" Nix
Plug 'LnL7/vim-nix'

" Natural Language
Plug 'dpelle/vim-LanguageTool'
let g:languagetool_jar='/usr/local/bin/languagetool'

" Coc - IntelliSense
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" source $HOME/.vim/coc/coc.vim

" Snippets etc.
Plug 'mattn/emmet-vim'

" file management
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'dyng/ctrlsf.vim'

" Git
"" Git wrapper
Plug 'tpope/vim-fugitive'

"" DiffTool
Plug 'whiteinge/diffconflicts'

" CTRL+P
Plug 'ctrlpvim/ctrlp.vim'
"" Don't scan git-ignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" NERDTree
Plug 'scrooloose/nerdtree', { 'commit': '8d005db' } " textual filesystem navigation.
map <Leader>n :NERDTreeToggle<CR>

" Natural Language writing
Plug 'junegunn/goyo.vim'

Plug 'https://manu@framagit.org/manu/coq-au-vim.git'

" Latex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Go
Plug 'fatih/vim-go'

" project tools/general vim stuff
Plug 'editorconfig/editorconfig-vim' " editorconfig support
Plug 'skywind3000/asyncrun.vim' " better async running

" writing/editing helpers
Plug 'tpope/vim-commentary' " easy commenting.
Plug 'ntpeters/vim-better-whitespace' " mark and remove trailing whitespace.

" misc
Plug 'tpope/vim-sensible' " sensible vim defaults.
Plug 'embear/vim-localvimrc' " load subdirectory specific vimrc files.
Plug 'jcf/vim-latex' " latex suite.
Plug 'liuchengxu/vim-which-key'
"Plug 'christoomey/vim-tmux-navigator'

" Organizational stuff
Plug 'vimwiki/vimwiki'

" Relative line numbers
Plug 'vim-scripts/RltvNmbr.vim'

Plug 'mattn/calendar-vim'
let g:calendar_diary=$HOME.'/vimwiki/diary'

call plug#end()
