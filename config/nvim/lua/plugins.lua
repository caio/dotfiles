return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'arcticicestudio/nord-vim',
        -- Does it need to be this verbose?
        config = [[vim.api.nvim_command "colorscheme nord"]]
    }

    use {
        'neovim/nvim-lspconfig',
        cmd = 'LspStart',
        config = [[require('config.lsp')]]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }
end)
