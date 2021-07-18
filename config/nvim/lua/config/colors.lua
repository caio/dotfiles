vim.o.termguicolors = true
vim.g.material_style = 'palenight'
vim.g.material_borders = true
vim.g.material_italic_comments = true

vim.cmd("colorscheme material")

require('lualine').setup({
    options = {
        theme = 'dracula',
        section_separators = '',
        component_separators = '',
        icons_enabled = false,
    },
    -- Disable the default "git branch" section
    sections = { lualine_b = {} },
})
