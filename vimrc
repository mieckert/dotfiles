set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

syntax on
let mapleader="-"
let s:path = expand('<sfile>:p')
execute "nnoremap <leader>ev :tabedit " . s:path . "<cr>"
execute "nnoremap <leader>sv :source " . s:path . "<cr>"
nnoremap <leader>/ :let @/=""<cr>
noremap <leader>h :tabnew\|help\|only<cr>
nnoremap <cr> <C-]>
nnoremap <C-j> <C-]>
set keymodel-=stopsel
set guifont=Consolas:h12:cANSI
set tabstop=4
set shiftwidth=4
set expandtab

if has("gui_running")
  set columns=120
  set lines=45
endif

if has("win32")
  set shell=cmd.exe
  let g:ruby_path="C:\Program Files (x86)\ruby-1.9.2-p136-i386-mswin32\bin"
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
endif

au BufNewFile,BufRead *.md setf markdown

let g:xml_syntax_folding=1

au FileType xml setlocal foldmethod=syntax
au FileType xml setlocal foldcolumn=8
au FileType xml execute "normal! zR"

