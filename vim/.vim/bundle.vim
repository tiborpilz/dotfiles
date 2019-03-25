" Install Vundle if it is not already installed
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Plugin Manager
Plugin 'VundleVim/Vundle.vim' " Plugin manager.

"Appearance

" Colorschemes.
Plugin 'flazz/vim-colorschemes' " Large colorscheme collection.
Plugin 'dylanaraps/wal.vim' " Custom color scheme from pywal

" Status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Icons
Plugin 'ryanoasis/vim-devicons'

" Syntax highlighting / linting / autocomplete
Plugin 'tmux-plugins/vim-tmux'
Plugin 'honza/dockerfile.vim'
Plugin 'tpope/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'joukevandermaas/vim-ember-hbs'
Plugin 'sbdchd/neoformat'

" File management
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'jremmen/vim-ripgrep'

" Langugage specific
"" Javascript/Frontend
Plugin 'pangloss/vim-javascript'
Plugin 'maksimr/vim-jsbeautify' " JavaScript beautify

Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

Plugin 'supercollider/scvim'


Plugin 'lervag/vimtex' "Latex Support
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" Plugin 'python-mode/python-mode' "Python Mode

" Plugin 'szymonmaszke/vimpyter'


" Project tools/General VIM stuff
Plugin 'editorconfig/editorconfig-vim' " Editorconfig support
Plugin 'skywind3000/asyncrun.vim' " Better async running

" Snippets.
Plugin 'MarcWeber/vim-addon-mw-utils' " Dependency.
Plugin 'tomtom/tlib_vim' " Dependency.
Plugin 'garbas/vim-snipmate' " Snipmate repo.
Plugin 'honza/vim-snippets' " Default snippets.

Plugin 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Wrappers.
Plugin 'tpope/vim-fugitive.git' " Git.
Plugin 'mipmip/vim-run-in-blender' " Blender.

" Writing/editing helpers.
Plugin 'tpope/vim-commentary' " Easy commenting.
Plugin 'ntpeters/vim-better-whitespace' " Mark and remove trailing whitespace.

" Misc.
Plugin 'tpope/vim-sensible' " Sensible vim defaults.
Plugin 'embear/vim-localvimrc' " Load subdirectory specific vimrc files.
Plugin 'scrooloose/nerdtree' " Textual filesystem navigation.
Plugin 'jcf/vim-latex' " LaTeX suite.
Plugin 'liuchengxu/vim-which-key'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
