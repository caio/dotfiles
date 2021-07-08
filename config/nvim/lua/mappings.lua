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

-- Act like a normal thing when navigating wrapped lines
map('n', "k", "gk", {})
map('n', "j", "gj", {})

map('c', "w!!", "w !sudo tee % &>/dev/null", {})

map('n', "<leader><space>", ":nohlsearch<CR>", { noremap = true, silent = true })


