return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- General-purpose editing plugins
    use {
        'tpope/vim-commentary',
        'tpope/vim-repeat',
        'tpope/vim-surround',
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

            vim.api.nvim_set_keymap('i' , '<CR>','v:lua.complete_or_autopairs()', {expr = true , noremap = true})
        end
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
            vim.cmd("colorscheme gord")
        ]]
    }

    use {
        'mcchrish/zenbones.nvim',
        requires = { 'rktjmp/lush.nvim', opt = true },
        config = [[
            vim.g.zenbones_darkness = "warm"
            vim.g.zenbones_lightness = "dim"
        ]]
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
