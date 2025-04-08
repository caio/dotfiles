return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- General-purpose editing plugins
    use {
        'tpope/vim-commentary',
        'tpope/vim-repeat',
        'tpope/vim-surround',
    }

    use {
        'tpope/vim-fugitive',
        cmd = 'Git',
    }

    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({})
        end
    }

    use { 'qpkorr/vim-renamer', cmd = 'Renamer' }

    use {
        'mcchrish/zenbones.nvim',
        config = function()
            vim.g.zenbones_compat = 1
            vim.g.zenbones_darkness = "stark" -- warm/undef
            vim.g.zenbones_lightness = "bright" -- dim/undef
            vim.opt.termguicolors = true
            vim.opt.background = "light"
            vim.cmd("colorscheme zenbones")
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function()
            require('config.telescope')
        end
    }
end)
