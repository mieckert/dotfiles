set shell=/bin/bash
set nocompatible
set number
syntax on
set mouse=a
set tabstop=4
set shiftwidth=4


let s:configdir = expand('<sfile>:p:h')
let &rtp .= s:configdir

exec ":source " . s:configdir . "/gui.vim"
exec ":source " . s:configdir . "/plugins.vim"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_include_dirs = [ '/opt/homebrew/include', 'include' ]


" Set a nice color scheme with a dark grey background; make cursorline visible only
" in the line number side bar, not the main text
" This needs to be near the end of the vimrc, so a syntax on / syntax enable
" as well as plugins etc. don't override it...
colorscheme slate
set cursorline
hi clear CursorLine
hi LineNr guibg=gray18
hi CursorLineNr term=bold cterm=bold ctermfg=14 gui=bold guifg=gray90 guibg=gray18

" Copied from mswin.vim to enable copy&paste keys etc.

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
" behave mswin
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" backspace in Visual mode deletes selection
vnoremap <BS> d
let g:neovide_input_use_logo = 1
noremap <D-v> "+p<CR>
noremap! <D-v> <C-R>+
tnoremap <D-v> <C-R>+
vnoremap <D-c> "+y<CR> 
