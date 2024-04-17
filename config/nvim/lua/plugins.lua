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
        'fatih/vim-go',
        -- ensure maximum regret when I open go files
        run = ':GoInstallBinaries',
        ft = {'go'},
        config = function()
            vim.g.go_gopls_enabled = 0
        end
    }

    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        requires = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup({})

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
    }

    -- Front-end stuff
    use {
        'yuezk/vim-js',
        'HerringtonDarkholme/yats.vim',
        'maxmellon/vim-jsx-pretty',
    }

    use { 'qpkorr/vim-renamer', cmd = 'Renamer' }

    use {
        'mcchrish/zenbones.nvim',
        requires = { 'rktjmp/lush.nvim' },
        config = function()
            vim.g.zenbones_darkness = "stark" -- warm/undef
            vim.g.zenbones_lightness = "bright" -- dim/undef
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd("colorscheme zenbones")
        end
    }

    -- autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
        },
        config = function()
            require('config.completions')
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function()
            require('config.telescope')
        end
    }

    -- Only gets loaded when `:LspStart` is called manually
    use {
        'neovim/nvim-lspconfig',
        cmd = 'LspStart',
        config = function()
            require('config.lsp')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('config.treesitter')
        end
    }
end)
