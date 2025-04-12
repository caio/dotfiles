local map = vim.keymap.set

map('i', "<F1>", "<ESC>")
map('n', "<F1>", "<ESC>")
map('v', "<F1>", "<ESC>")

map('n', ",", "zA")
map('v', ",", "zA")

map('v', "'", "`")
map('v', "`", "'")

-- Re-select block after (de)indent
map('v', "<", "<gv")
map('v', ">", ">gv")

-- Faster window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-Tab>', ':tabnext<CR>')
map('n', '<C-S-Tab>', ':tabprevious<CR>')

-- Easier marking on intl keyboards
map('n', "'", "`")
map('n', "`", "'")

-- Act like a normal thing when navigating wrapped lines
map('n', "k", "gk")
map('n', "j", "gj")

local opts = { silent = true }
map('n', "<leader><space>", ":nohlsearch<CR>", opts)

map('n', '0', ":lua require('custom').caret_or_zero()<CR>", opts)
