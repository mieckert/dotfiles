" vim GUI settings (font, window size, etc.)
if exists("g:neovide")
    set guifont=Menlo:h16
elseif has("gui_running") " only set in gvim (not neovide, nvim-qt, etc.)
    if has("gui_macvim")
        set guifont=Menlo:h16
    else
        set guifont=Consolas:h12:cANSI
    endif
    
    set columns=80
    set lines=35
endif


