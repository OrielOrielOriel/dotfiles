" vim-plug {{{
call plug#begin('~/dotfiles/nvim/plugged')

" color schemes
Plug 'https://github.com/cocopon/iceberg.vim'
Plug 'https://github.com/whatyouhide/vim-gotham'
Plug 'https://github.com/cseelus/vim-colors-lucid'
Plug 'https://github.com/NLKNguyen/papercolor-theme'

" UI Elements
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'

" LSP
Plug 'https://github.com/neovim/nvim-lspconfig' 

call plug#end()
" }}} vim-plug

" Color Scheme Settings {{{
set termguicolors
colorscheme iceberg
" }}} Color Scheme Settings

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" Autochange indent for .yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" }}} Spaces & Tabs

" UI Config {{{
set number relativenumber
set cursorline
syntax on
"  }}} UI Config

" Nerdtree {{{
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" }}} Nerdtree

" Autotoggle relativenumber {{{
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,Focuslost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END
" }}} Autotoggle relativenumber

lua << EOF
require'lspconfig'.pyright.setup{}
EOF
