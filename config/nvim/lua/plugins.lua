return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- General-purpose editing plugins
    use {
        'tpope/vim-commentary',
        'tpope/vim-repeat',
        'tpope/vim-surround',
        'cohama/lexima.vim',
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

    -- Appearance
    use {
        '~/src/personal/gord.nvim/',
        requires = { 'rktjmp/lush.nvim', opt = true },
        config = [[
            vim.opt.termguicolors = true
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1
            vim.g.nord_underline = 1

            vim.cmd("colorscheme gord")
        ]]
    }

    use {
        'hoob3rt/lualine.nvim',
        config = [[
            require('lualine').setup({
                options = {
                    theme = 'nord',
                    section_separators = '',
                    component_separators = '',
                    icons_enabled = false,
                },
                -- Disable the default "git branch" section
                sections = { lualine_b = {} },
            })
        ]],
    }

    -- Fancyful pop-up/floating windows with fuzzy finding support
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
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
