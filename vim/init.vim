set shell=/bin/bash
set nocompatible
set number
syntax on

" vim GUI settings (font, window size, etc.)
if has("gui_running")
    echo "gui_running"
    if has("gui_macvim")
        set guifont=Menlo:h16
    else
        set guifont=Consolas:h12:cANSI
    endif
    
    set columns=120
    set lines=25
    set mouse=a
endif

if exists("g:neovide")
    set mouse=a
    set guifont=Menlo:h16
endif


" Add Vundle package manager to runtime path (located in ~/dotfiles/vim/Vundle.vim)
" and initalize it; filetype must be set to off according to Vundle docs
filetype off
let s:vundle = expand('<sfile>:p:h') . "/vim/Vundle.vim"
let &rtp .= ',' . s:vundle

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Syntax checking etc.
Plugin 'vim-syntastic/syntastic'

" Rust support
Plugin 'rust-lang/rust.vim'

" End of Vundle section, filetype required by VUndle
call vundle#end()
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Set a nice color scheme with a dark grey background; make cursorline visible only
" in the line number side bar, not the main text
" This needs to be near the end of the vimrc, so a syntax on / syntax enable
" as well as plugins etc. don't override it...
colorscheme slate
set cursorline
hi clear CursorLine
hi LineNr guibg=gray18
hi CursorLineNr term=bold cterm=bold ctermfg=14 gui=bold guifg=gray90 guibg=gray18
