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
-- Launching the lsp server doesn't work with a non-posix shell...
opt.shell = "/bin/bash"

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

g.mapleader = ','
g.smartmatch = true
-- A way less "in your face" netrw
g.netrw_sizestyle="h"
g.netrw_banner=0
g.netrw_list_style=3
g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
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
        fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_path})
        vim.api.nvim_command 'packadd packer.nvim'
        cmd [[echo "Bootstrapped! Restart and +PackerSync to install plugins"]]
    end

    cmd [[command! BootstrapPacker lua packer_bootstrap() ]]
    cmd [[echo "Plugins disabled! Run :BootstrapPacker to setup"]]
else
    require('plugins')
end
