-- Settings {{{
local opt, g = vim.o, vim.g

opt.shortmess = "at"
opt.showmatch = true
opt.ignorecase = true
opt.hidden = true
opt.scrolloff = 3
opt.shada = "'1000,f1,<500,:1000,/1000,h"
opt.history = 500
opt.backspace = "indent,eol,start"
opt.errorbells = false
opt.visualbell = false
opt.completeopt = "menuone,noselect,preview"
opt.linebreak = true
opt.showbreak = "↪"
opt.virtualedit = "block"
opt.foldlevelstart = 99
opt.shiftround = true
opt.wildmode = "list:longest"
opt.mouse = "n"

opt.wrap = false
opt.list = true
opt.listchars = [[tab:▸ ,trail:·,precedes:…,extends:…,nbsp:‗]]
opt.cursorline = true
opt.foldmethod = "marker"
opt.shiftwidth = 4
opt.textwidth = 79
opt.expandtab = true
opt.softtabstop = 4
opt.formatoptions = "qrn1"
opt.undofile = true
opt.swapfile = false
opt.smartcase = true

g.mapleader = ' '
-- A way less "in your face" netrw
g.netrw_sizestyle = "h"
g.netrw_banner = 0
g.netrw_list_style = 3
g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

vim.diagnostic.config({
    virtual_text = {
        severity = {
            -- TODO ability to cycle this `min` setting since I do like
            --      warnings in my face after prototyping is done
            min = vim.diagnostic.severity.ERROR,
            max = vim.diagnostic.severity.ERROR,
        },
        spacing = 2,
        source = "if_many",
    },
})
-- }}}

vim.g.zenbones_darkness = "stark"   -- warm/undef
vim.g.zenbones_lightness = "bright" -- dim/undef
vim.opt.termguicolors = true
vim.opt.background = "light"
vim.cmd("colorscheme zenbones")

require('mappings')
require("config.lsp")
require('nvim-autopairs').setup({})
require('config.telescope')

-- Don't leave preview windows hanging
vim.api.nvim_create_autocmd({ 'CursorMovedI', 'InsertLeave' }, {
    command = "if pumvisible() == 0| pclose | endif"
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        require('custom').jump_to_last_position()
    end
})

-- Load local (unversioned) settings if they exist
if vim.fn.filereadable(vim.fn.expand('~/.vimrc.lua')) then
    vim.cmd.so("~/.vimrc.lua")
end
