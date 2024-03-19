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
        run = ':GoInstallBinaries',
        ft = {'go'},
        config = function()
            vim.g.go_gopls_enabled = 0
        end
    }

    use {
        'windwp/nvim-autopairs',
        requires = { 'hrsh7th/nvim-cmp' },
        config = function()
            local autopairs = require('nvim-autopairs')
            autopairs.setup({})

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
        config = [[
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd("colorscheme zenbones")
        ]]
    }

    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
        },
        config = [[require('config.completions')]]
    }

    -- Fancyful pop-up/floating windows with fuzzy finding support
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = [[require('config.telescope')]]
    }

    -- Settings for the built-in LSP client
    -- Only gets loaded when `:LspStart` is called manually
    use {
        'neovim/nvim-lspconfig',
        cmd = 'LspStart',
        config = [[require('config.lsp')]]
    }

    -- Treesitter-based syntax support
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }
end)
