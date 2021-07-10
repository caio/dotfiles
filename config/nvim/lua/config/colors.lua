local g = vim.g

g.nord_contrast = true
g.nord_borders = false
g.nord_disable_background = true

vim.cmd('colorscheme nord')

require('lualine').setup({
    options = {
        theme = 'nord',
        section_separators = '',
        component_separators = '',
    },
    -- Disable the default "git branch" section
    sections = { lualine_b = {} },
})
