" Add Vundle package manager to runtime path (located in 
" ~/dotfiles/vim/Vundle.vim) and initalize it
" TODO: check if this is a good way (because vundle will
" then also take over the managment of itself and manage it
" in the usual path, not the one from dotfiles
let s:vundle = expand('<sfile>:p:h') . "/Vundle.vim"
let &rtp .= ',' . s:vundle

" filetype must be set to off according to Vundle docs
filetype off

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Syntax checking etc.
Plugin 'vim-syntastic/syntastic'

" Rust support
Plugin 'rust-lang/rust.vim'

" End of Vundle section, filetype required by VUndle
call vundle#end()
filetype plugin indent on

