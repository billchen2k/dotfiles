" @billchen2k's configuration
" created: 2020.7
" updated: 2024.11

syntax on
set rnu!
set nu!
set autoindent
set rulerformat=%35(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set mouse=a
set showmatch
set ruler
set autoread
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set foldenable

highlight ColorColumn ctermbg=darkgray
set colorcolumn=120
set backspace=indent,eol,start
set incsearch
set ignorecase

scriptencoding utf-8
set listchars+=trail:·
set listchars+=tab:→\
set list

" connect system clipboard (use star register)
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "+Y
noremap <Leader>P "+P

"" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeWinPos = "right"
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
let g:NERDTreeMouseMode=3


""""" airline
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled  = 1
let g:airline#extensions#tabline#enabled    = 1

""""" nerdcommenter
let g:NERDSpaceDelims   = 1

""""" copilot
" Disable Copilot by default
let g:copilot_enabled = v:false


call plug#begin()

Plug 'projekt0n/github-nvim-theme'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-sensible'
Plug 'ap/vim-css-color'
Plug 'github/copilot.vim'
Plug 'wakatime/vim-wakatime'

call plug#end()

colorscheme pablo
if has('nvim') && v:version > 800
    colorscheme github_dark_dimmed
endif

