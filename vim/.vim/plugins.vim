set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin('~/.vim/plugged')

" colorschemes
Plug 'flazz/vim-colorschemes' " large colorscheme collection.
Plug 'noahfrederick/vim-noctu' " 16-Color ANSI
Plug 'dylanaraps/wal.vim' " custom color scheme from pywal

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" icons
Plug 'ryanoasis/vim-devicons'

" general syntax highlighting / linting / autocomplete
Plug 'honza/dockerfile.vim'
Plug 'tpope/vim-markdown'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <c-space>
      \ pumvisible() ? "\<c-space>"
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" linting using ale
" Plug 'dense-analysis/ale'

" let g:ale_sign_error = 'E' " less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
" let g:ale_lint_on_enter = 1
" let g:ale_set_baloons = 1
" let g:ale_sign_column_always = 1
" let g:airline#extensions#ale#enabled = 1
" let g:ale_fix_on_save = 1
" let g:ale_linters = { 'javascript': ['prettier'], 'typescript': ['prettier'] }

" file management
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" CTRL+P
Plug 'ctrlpvim/ctrlp.vim'

"" Don't scan git-ignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" NERDTree
Plug 'scrooloose/nerdtree', { 'commit': '8d005db' } " textual filesystem navigation.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrow = 0

map <Leader>n :NERDTreeToggle<CR>

" javascript/frontend general
Plug 'pangloss/vim-javascript'
augroup javascript_folding
  au!
  au filetype javascript setlocal foldmethod=syntax
augroup end

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_nan                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "ω"
let g:javascript_conceal_arrow_function       = "⇒"

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'darthmall/vim-vue'

" markdown
Plug 'junegunn/goyo.vim'

" latex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" project tools/general vim stuff
Plug 'editorconfig/editorconfig-vim' " editorconfig support
Plug 'skywind3000/asyncrun.vim' " better async running

" snippets
Plug 'marcweber/vim-addon-mw-utils' " dependency.
Plug 'tomtom/tlib_vim' " dependency.
Plug 'garbas/vim-snipmate' " snipmate repo.
Plug 'honza/vim-snippets' " default snippets.

" wrappers
Plug 'tpope/vim-fugitive' " git.
Plug 'mipmip/vim-run-in-blender' " blender.

" writing/editing helpers
Plug 'tpope/vim-commentary' " easy commenting.
Plug 'ntpeters/vim-better-whitespace' " mark and remove trailing whitespace.

" misc
Plug 'tpope/vim-sensible' " sensible vim defaults.
Plug 'embear/vim-localvimrc' " load subdirectory specific vimrc files.
Plug 'jcf/vim-latex' " latex suite.
Plug 'liuchengxu/vim-which-key'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vimwiki/vimwiki'

call plug#end()
