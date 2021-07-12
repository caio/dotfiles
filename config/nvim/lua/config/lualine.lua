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
