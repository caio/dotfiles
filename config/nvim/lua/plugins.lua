return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'arcticicestudio/nord-vim',
        -- Does it need to be this verbose?
        config = [[vim.api.nvim_command "colorscheme nord"]]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }
end)
