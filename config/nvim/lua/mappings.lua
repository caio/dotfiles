local map = vim.api.nvim_set_keymap

local function noremap(mode, key, action)
  map(mode, key, action, { noremap = true })
end

noremap('i', "<F1>", "<ESC>")
noremap('n', "<F1>", "<ESC>")
noremap('v', "<F1>", "<ESC>")

noremap('n', "<space>", "za")
noremap('v', "<space>", "za")

noremap('v', "'", "`")
noremap('v', "`", "'")

-- Re-select block after (de)indent
noremap('v', "<", "<gv")
noremap('v', ">", ">gv")

-- Faster window nagivation
noremap('n', '<C-h>', '<C-w>h')
noremap('n', '<C-l>', '<C-w>l')
noremap('n', '<C-j>', '<C-w>j')
noremap('n', '<C-k>', '<C-w>k')

-- Easier marking on intl keyboards
noremap('n', "'", "`")
noremap('n', "`", "'")

-- Act like a normal thing when navigating wrapped lines
map('n', "k", "gk", {})
map('n', "j", "gj", {})

map('n', "<leader><space>", ":nohlsearch<CR>", { noremap = true, silent = true })

