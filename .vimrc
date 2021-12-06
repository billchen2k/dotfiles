" @BillChen2K's Configuration
" V2020.7
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
set colorcolumn=140
set backspace=indent,eol,start

" autocmd InsertEnter * se cul
" set fdm=syntax

" inoremap ' ''<ESC>i
" inoremap " ""<ESC>i
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i
" inoremap {<CR> {<CR>}<ESC>O
function! RemovePairs()
    let s:line = getline(".")
    let s:previous_char = s:line[col(".")-1]

    if index(["(","[","{"],s:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " only right (
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            execute "normal! v%xa"
        else
            execute "normal! v%xi"
        end
    else
        execute "normal! a\<BS>"
    end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
endfunction

" inoremap <BS> <ESC>:call RemovePairs()<CR>a
" inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
" inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
" inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
" inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""
" Configurations for vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdcommenter'
Plugin 'DoxygenToolkit.vim'
Plugin 'ReedOei/vim-maude'
Plugin 'preservim/nerdtree'

" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"""""""""""""""""""""""""""""""""""""""""""""""""