vim.o.termguicolors = true
vim.g.material_style = 'palenight'
vim.g.material_borders = true
vim.g.material_italic_comments = true

vim.cmd("colorscheme material")

function toggle_style()
    local change_style = require('material.functions').change_style

    if vim.g.material_style == 'palenight' then
        change_style('lighter')
    else
        change_style('palenight')
    end
end

vim.cmd([[command! ToggleStyle lua toggle_style()]])


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
