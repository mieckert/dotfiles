let s:configdir = expand('<sfile>:p:h')
let &rtp .= s:configdir

exec ":source " . s:configdir . "/gui.vim"
exec ":source " . s:configdir . "/plugins.vim"
exec ":source " . s:configdir . "/lsp.lua"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_include_dirs = [ '/opt/homebrew/include', 'include' ]
