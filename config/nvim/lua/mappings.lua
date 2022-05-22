local map = vim.keymap.set

map('i', "<F1>", "<ESC>")
map('n', "<F1>", "<ESC>")
map('v', "<F1>", "<ESC>")

map('n', "<space>", "zA")
map('v', "<space>", "zA")

map('v', "'", "`")
map('v', "`", "'")

-- Re-select block after (de)indent
map('v', "<", "<gv")
map('v', ">", ">gv")

-- Faster window nagivation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')

-- Easier marking on intl keyboards
map('n', "'", "`")
map('n', "`", "'")

-- Faster buffer switching
map('n', "<leader>n", ":bn<CR>")
map('n', "<leader>m", ":bp<CR>")

-- Act like a normal thing when navigating wrapped lines
map('n', "k", "gk")
map('n', "j", "gj")

local opts = { silent = true }
map('n', "<leader><space>", ":nohlsearch<CR>", opts)

map('n', '0', ":lua require('custom').caret_or_zero()<CR>", opts)

-- Next/Previous diagnostic
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']ed', '<cmd>lua vim.diagnostic.goto_next({ severity = "Error"})<CR>', opts)
map('n', '[ed', '<cmd>lua vim.diagnostic.goto_prev({ severity = "Error"})<CR>', opts)
-- Show a pop-up with the line diagnostic details
map('n', '<C-n>', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
