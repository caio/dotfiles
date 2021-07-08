-- Settings {{{
local set = vim.api.nvim_set_option

set('shortmess', "at")
set('showmatch', true)
set('ignorecase', true)
set('hidden', true)
set('scrolloff', 3)
set('shada', "'1000,f1,<500,:1000,/1000,h")
set('history', 500)
set('backspace', "indent,eol,start")
set('errorbells', false)
set('visualbell', false)
set('completeopt', "menu,menuone,noinsert,noselect,preview")
set('showbreak', "↪")
set('virtualedit', "block")
set('foldlevelstart', 0)
set('shiftround', true)
set('wildmode', "list:longest")
set('updatetime', 300)

local global, window, buffer = vim.g, vim.wo, vim.bo

global.mapleader = ','
global.smartmatch = true

-- A way less "in your face" netrw
global.netrw_sizestyle="h"
global.netrw_banner=0
global.netrw_list_style=3
global.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

window.wrap = false
window.list = true
window.listchars = [[tab:▸ ,trail:·,precedes:…,extends:…,nbsp:‗]]
window.cursorline = true
window.foldmethod = "marker"

buffer.shiftwidth = 4
buffer.textwidth = 79
buffer.expandtab = true
buffer.softtabstop = 4
buffer.formatoptions = "qrn1"
buffer.undofile = true
buffer.swapfile = false
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
