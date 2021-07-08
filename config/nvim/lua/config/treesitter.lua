require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash', 'comment', 'css', 'go', 'html', 'javascript', 'json', 'lua',
    'python', 'regex', 'rust', 'toml', 'typescript', 'yaml', 'fish'
  },
  highlight = {enable = true, use_languagetree = true},
  refactor = {
    -- smart_rename = {enable = true, keymaps = {smart_rename = "rn"}},
    -- highlight_current_scope = { enable = true },
    highlight_definitions = {enable = true}
  },
}
