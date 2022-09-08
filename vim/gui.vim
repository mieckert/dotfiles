" vim GUI settings (font, window size, etc.)
if has("gui_running") " only set in gvim (not neovide, nvim-qt, etc.)
    if has("gui_macvim")
        set guifont=Menlo:h16
    else
        set guifont=Consolas:h12:cANSI
    endif
    
    set columns=80
    set lines=35
endif

if exists("g:neovide")
    set guifont=Menlo:h16
endif

