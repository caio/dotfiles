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
opt.completeopt = "menu,menuone,noinsert,noselect,preview"
opt.showbreak = "↪"
opt.virtualedit = "block"
opt.foldlevelstart = 0
opt.shiftround = true
opt.wildmode = "list:longest"
opt.mouse = "" -- ffs

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

g.mapleader = ','
-- A way less "in your face" netrw
g.netrw_sizestyle="h"
g.netrw_banner=0
g.netrw_list_style=3
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

-- Configure general-purpose mappings
-- Plugin-related ones are managed along with the plugins
require('mappings')

-- Load plugins via `packer`
-- If the packer installation is not found, no plugins
-- will be configured.
local fn, cmd = vim.fn, vim.cmd
local packer_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_path)) > 0 then

    function packer_bootstrap()
        cmd [[echo "Cloning packer.nvim..."]]
        fn.system({'git', 'clone','--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_path})
        vim.api.nvim_command('packadd packer.nvim')
        require('plugins')
        vim.cmd('autocmd User PackerComplete quitall!')
        vim.api.nvim_command('PackerSync')
    end

    cmd [[command! BootstrapPacker lua packer_bootstrap() ]]
    cmd [[echo "Plugins disabled! Run :BootstrapPacker to install and exit"]]
else
    require('plugins')
end

-- Don't leave preview windows hanging
cmd("autocmd CursorMovedI * if pumvisible() == 0|pclose|endif")
cmd("autocmd InsertLeave * if pumvisible() == 0|pclose|endif")

cmd("autocmd BufReadPost * lua require('custom').jump_to_last_position()")
