-- Source shared Vimscript configuration
vim.cmd('source ~/dotfiles/common.vim')

if vim.g.neovide then
    vim.opt.guifont = "Menlo:h16"
end

-- MOVED over to common.vim since vim also uses netrw and has the same settings
-- Open a tree view with :Lexplore (sidebar) or :Explore (full screen)
-- Set the style to a tree-view layout
-- vim.g.netrw_liststyle = 3
-- Hide the bloated help banner at the top of the window
-- vim.g.netrw_banner = 0
-- Set the sidebar width to 25% of the screen
-- vim.g.netrw_winsize = 25


vim.pack.add { 
    { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable('pyright')
vim.lsp.enable('emmylua_ls')
vim.lsp.enable('rust_analyzer')

vim.lsp.inlay_hint.enable(true)

