require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash', 'comment', 'css', 'go', 'html', 'javascript', 'json', 'lua',
    'python', 'regex', 'rust', 'toml', 'typescript', 'yaml', 'fish'
  },
  highlight = {enable = true, use_languagetree = true},
}
