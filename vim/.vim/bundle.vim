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

""" Vim Appearance

" Colorschemes.
Plugin 'flazz/vim-colorschemes' " Large colorscheme collection.
Plugin 'distinguished' " Dark color scheme for 256-color terminals.
Plugin 'dylanaraps/wal.vim' " Custom color scheme from pywal

" Status line
Plugin 'vim-airline/vim-airline'

" Syntax highlighting.
Plugin 'honza/dockerfile.vim'
Plugin 'tpope/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'joukevandermaas/vim-ember-hbs'

" Linting etc.
Plugin 'w0rp/ale'

" File management
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'jremmen/vim-ripgrep'

" Langugage specific
"" Javascript/Frontend
Plugin 'maksimr/vim-jsbeautify' " JavaScript beautify
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'lervag/vimtex' "Latex Support
" Plugin 'python-mode/python-mode' "Python Mode

Plugin 'szymonmaszke/vimpyter'
Plugin 'ivanov/vim-ipython'


" Project tools/General VIM stuff
Plugin 'editorconfig/editorconfig-vim' " Editorconfig support
Plugin 'skywind3000/asyncrun.vim' " Better async running

" Snippets.
Plugin 'MarcWeber/vim-addon-mw-utils' " Dependency.
Plugin 'tomtom/tlib_vim' " Dependency.
Plugin 'garbas/vim-snipmate' " Snipmate repo.
Plugin 'honza/vim-snippets' " Default snippets.

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

call vundle#end()
