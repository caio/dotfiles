local map = vim.api.nvim_set_keymap

local function noremap(mode, key, action)
  map(mode, key, action, { noremap = true })
end

noremap('i', "<F1>", "<ESC>")
noremap('n', "<F1>", "<ESC>")
noremap('v', "<F1>", "<ESC>")

noremap('n', "<space>", "zA")
noremap('v', "<space>", "zA")

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

-- Faster buffer switching
noremap('n', "<leader>n", ":bn<CR>")
noremap('n', "<leader>m", ":bp<CR>")

-- Act like a normal thing when navigating wrapped lines
map('n', "k", "gk", {})
map('n', "j", "gj", {})

local opts = { silent = true, noremap =  true }
map('n', "<leader><space>", ":nohlsearch<CR>", opts)

map('n', '0', ":lua require('custom').caret_or_zero()<CR>", opts)

-- Next/Previous diagnostic
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']ed', '<cmd>lua vim.diagnostic.goto_next({ severity = "Error"})<CR>', opts)
map('n', '[ed', '<cmd>lua vim.diagnostic.goto_prev({ severity = "Error"})<CR>', opts)
-- Show a pop-up with the line diagnostic details
map('n', '<C-n>', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
