return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }
end)
