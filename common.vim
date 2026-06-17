syntax on

set nocompatible
set number
set mouse=a

" TODO: should be cmd.exe on Windows; needs to be change with if has("win32") etc.?
set shell=/bin/bash

" Tab and identation handling
set tabstop=4
set shiftwidth=4
set expandtab

" Keyboard shortcuts, leader commands etc.
let mapleader="-"
let maplocalleader="_"
" -/: Remove search highlighting 
nnoremap <leader>/ :let @/=""<cr>
" -h: Show help in new tab
noremap <leader>h :tabnew\|help\|only<cr>
nnoremap <cr> <C-]>
nnoremap <C-j> <C-]>
set keymodel-=stopsel

" Setting a few things to behave "more normal"
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" backspace in Visual mode deletes selection
vnoremap <BS> d

" TODO: This works for neovide, but not in terminal unfortunately
" Set up clipboard / CMD+C/V
set clipboard=unnamedplus
" Let neovide "claim" the CMD/Windows key and send it as <D>-modifier
" (super-modifier)
let g:neovide_input_use_logo = 1
noremap <D-v> "+p
noremap! <D-v> <C-R>+
tnoremap <D-v> <C-\><C-n>"+pa
vnoremap <D-c> "+y
vnoremap <C-c> "+y
vnoremap <M-c> "+y
vnoremap <F13> "+y


" Open a tree view with :Lexplore (sidebar) or :Explore (full screen)
" Set the style to a tree-view layout
let g:netrw_liststyle = 3
" Hide the bloated help banner at the top of the window
let g:netrw_banner = 0
" Set the sidebar width to 25% of the screen
let g:netrw_winsize = 25


" Set curor shape
" Define cursor shapes inside the editors
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" Force the cursor back to an underline when exiting, so it doesn't mess up the terminal cursor
autocmd VimLeave,VimSuspend * set guicursor=a:hor20

" Get rid of backup files and live on the edge
set nobackup
set nowritebackup
set noswapfile

" Use smartcase for search (i.e., case-sensitive search if search keyword
" contains upper-case letters, case-insenstivie otherwise).  Using smartcase
" requires ignorecase to be on!
set ignorecase
set smartcase

" Set a nice color scheme with a dark grey background; make cursorline visible only
" in the line number side bar, not the main text
" This needs to be near the end of the vimrc, so a syntax on / syntax enable
" as well as plugins etc. don't override it...
colorscheme habamax
set cursorline
hi clear CursorLine
hi LineNr guibg=gray18
hi CursorLineNr term=bold cterm=bold ctermfg=14 gui=bold guifg=gray90 guibg=gray18
