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
        config = function()
            local autopairs = require('nvim-autopairs')

            autopairs.setup({})

            function complete_or_autopairs()
                if vim.fn.pumvisible() ~= 0  then
                    return autopairs.esc("<cr>")
                else
                    return autopairs.autopairs_cr()
                end
            end

            vim.keymap.set('i' , '<CR>','v:lua.complete_or_autopairs()', {expr = true})
        end
    }

    -- Front-end stuff
    use {
        'yuezk/vim-js',
        'HerringtonDarkholme/yats.vim',
        'maxmellon/vim-jsx-pretty',
    }

    -- Visual indentation guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g.indent_blankline_show_first_indent_level = false
            vim.g.indent_blankline_show_trailing_blankline_indent = false
        end
    }

    use { 'qpkorr/vim-renamer', cmd = 'Renamer' }

    use {
        'mcchrish/zenbones.nvim',
        requires = { 'rktjmp/lush.nvim', opt = true },
        config = [[
            vim.g.zenbones_darkness = "warm"
            vim.g.zenbones_lightness = "dim"

            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd("colorscheme zenbones")
        ]]
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
