call plug#begin('~/.config/nvim/plugged')

" Copilot
Plug 'github/copilot.vim'

" Dashboard
Plug 'glepnir/dashboard-nvim'
let g:dashboard_default_executive = 'telescope'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" NERDtree
Plug 'preservim/nerdtree'
nnoremap <leader>n :NERDTreeToggle<CR>

Plug 'andrewstuart/vim-kubernetes'

" Tabline
" Plug 'romgrk/barbar.nvim'
" Folds
Plug 'scr1pt0r/crease.vim'
" Statusline
if !exists('g:started_by_firenvim')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_theme = 'base16'
endif

" comments
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" planning/organization
Plug 'vimwiki/vimwiki'

" Languages
"" Terraform
Plug 'hashivim/vim-terraform'

"" Nix
Plug 'LnL7/vim-nix'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'simrat39/symbols-outline.nvim'
nnoremap <leader>o <cmd>SymbolsOutline <cr>

" Repl
Plug 'hkupty/iron.nvim'

Plug 'kosayoda/nvim-lightbulb'
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

Plug 'michaelb/sniprun', {'do': 'bash install.sh'}

" kubernetes
Plug 'rottencandy/vimkubectl'

" Plug 'SirVer/ultisnips'

" Colorschemes
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'kdheepak/monochrome.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'RRethy/nvim-base16'

" Autocompletion
Plug 'hrsh7th/nvim-compe'

" Signatures
Plug 'ray-x/lsp_signature.nvim'

set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

call plug#end()

" let g:nightfox_style = 'nordfox'
colorscheme nightfox

" LSP settings
lua require('lsp-config')

" Treesitter settings
lua require('treesitter')
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" LSP Signature setup
lua require('lsp-signature')

" Iron repl config
lua require('iron-config')

" Dashboard settings
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]
