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

let s:path = expand('<sfile>:p')
let s:folder = expand('<sfile>:p:h')

let &runtimepath.=',' . s:folder . "/vimfiles"
"let &runtimepath.=',' . s:folder . "/vimfiles/vim-snippets"

" Start Pathogen package manager (required by syntastic and other packages)
execute pathogen#infect()

syntax on
let mapleader="-"
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
  set mouse=a
endif

if has("win32")
  set shell=cmd.exe
  let g:ruby_path="C:\Program Files (x86)\ruby-1.9.2-p136-i386-mswin32\bin"
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
endif

au BufNewFile,BufRead *.md setf markdown

" Enable folding for XML files and make sure that everything is unfolded on
" startup
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml setlocal foldcolumn=8
au FileType xml execute "normal! zR"

" Settings for synastic syntax checker (jshint etc.)
" see https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt
let g:syntastic_check_on_open = 1

" Make sure that the menu language is English
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Move tabs with Ctrl-Shift-PageUp/Down
" See http://stackoverflow.com/questions/2106138/rearrange-tabs-with-the-mouse-in-gvim
nnoremap <silent> <C-S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
inoremap <silent> <C-S-PageDown> <C-O>:execute 'silent! tabmove ' . tabpagenr()<CR>
inoremap <silent> <C-S-PageDown> <C-O>:execute 'silent! tabmove ' . tabpagenr()<CR>


" Autocompletion with CTRL-space
inoremap <C-Space> <C-X><C-I>
nnoremap <C-Space> cw<C-X><C-I>


" SnipMate keys
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger
imap <C-K> <Plug>snipMateBack
smap <C-K> <Plug>snipMateBack
imap <C-L> <Plug>snipMateShow
smap <C-L> <Plug>snipMateShow
"imap <C-J> <C-O>:echom 'sm_i_nextOrTrigger'<CR><Plug>snipMateNextOrTrigger
"smap <C-J> <ESC>:echom 'sm_s_nextOrTrigger'<CR>gh<Plug>snipMateNextOrTrigger
"imap <C-K> <C-O>:echom 'sm_i_back'<CR><Plug>snipMateBack
"smap <C-K> <ESC>:echom 'sm_s_back'<CR>gh<Plug>snipMateBack
"imap <C-L> <C-O>:echom 'sm_i_show'<CR><Plug>snipMateShow
"smap <C-L> <ESC>:echom 'sm_s_show'<CR>gh<Plug>snipMateShow
"nnoremap <leader>sm :SnipMateOpenSnippetFiles<CR>
execute "nnoremap <leader>es :tabedit " . s:folder . "/vimfiles/snippets/<cr>"

let g:snipMate = {}
let g:snipMate['no_match_completion_feedkeys_chars'] = ""

au FileType snippets setlocal foldcolumn=8
au FileType snippets execute "normal! zR"

" Override filetype for json (don't use javascript!)
augroup filetypedetect
  au! BufNewFile,BufRead *.json setf json
augroup END


" Increment, decrement commands (usually CTRL-X and CTRL-A; but re-mapped
" since CTRL-A is used in windows to select the whole buffer)
set nrformats=hex
nnoremap <leader>a <C-A>
nnoremap <leader>x <C-X>


" Use smartcase for search (i.e., case-sensitive search if search keyword
" contains upper-case letters, case-insenstivie otherwise).  Using smartcase
" requires ignorecase to be on!
set ignorecase
set smartcase


" Set a nice color scheme with a dark grey background
colorscheme slate

function! SnipMateStatus()
    if exists("b:snip_state")
        let b:statusline_snip_state = "*** SNIP ***"
    else
        let b:statusline_snip_state = "no snip"
    endif
    return b:statusline_snip_state
endfunction

"set statusline+=%{SnipMateStatus()}
"set statusline=%!SnipMateStatus()
