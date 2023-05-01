" Config for MacVim

" UI
set number
set relativenumber
set cursorline

" Editing
set clipboard=unnamed
set expandtab
set mouse=a
set smartcase

" Indent
set shiftwidth=2
set shiftround
set smartindent
set tabstop=2

" Autoread
set autoread
au FocusGained,BufEnter * checktime

" Font
set guifont=MapleMonoNerdFontCompleteM-Regular:h15

" Theme
packadd! onedark.vim
colorscheme onedark

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry
