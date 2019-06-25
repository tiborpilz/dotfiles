" Prelimenary setup
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Vundle itself
Plugin 'vundlevim/vundle.vim'

" colorschemes
Plugin 'flazz/vim-colorschemes' " large colorscheme collection.
Plugin 'dylanaraps/wal.vim' " custom color scheme from pywal

" status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" icons
Plugin 'ryanoasis/vim-devicons'

" general syntax highlighting / linting / autocomplete
Plugin 'tmux-Plugins/vim-tmux'
Plugin 'honza/dockerfile.vim'
Plugin 'tpope/vim-markdown'

" linting using ale
Plugin 'w0rp/ale'

let g:ale_sign_error = '●' " less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 1
let g:ale_set_baloons = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = { 'javascript': ['eslint'], 'typescript': ['eslint'] }

" file management
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'jremmen/vim-ripgrep'

" javascript/frontend general
Plugin 'pangloss/vim-javascript'
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

Plugin 'mxw/vim-jsx'
Plugin 'prettier/vim-prettier'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

" latex
Plugin 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" project tools/general vim stuff
Plugin 'editorconfig/editorconfig-vim' " editorconfig support
Plugin 'skywind3000/asyncrun.vim' " better async running

" snippets
Plugin 'marcweber/vim-addon-mw-utils' " dependency.
Plugin 'tomtom/tlib_vim' " dependency.
Plugin 'garbas/vim-snipmate' " snipmate repo.
Plugin 'honza/vim-snippets' " default snippets.

" wrappers
Plugin 'tpope/vim-fugitive.git' " git.
Plugin 'mipmip/vim-run-in-blender' " blender.

" writing/editing helpers
Plugin 'tpope/vim-commentary' " easy commenting.
Plugin 'ntpeters/vim-better-whitespace' " mark and remove trailing whitespace.

" misc
Plugin 'tpope/vim-sensible' " sensible vim defaults.
Plugin 'embear/vim-localvimrc' " load subdirectory specific vimrc files.
Plugin 'scrooloose/nerdtree' " textual filesystem navigation.
Plugin 'jcf/vim-latex' " latex suite.
Plugin 'liuchengxu/vim-which-key'
Plugin 'tmux-Plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vimwiki/vimwiki'

call vundle#end()
