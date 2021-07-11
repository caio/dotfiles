local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Run cursor+timer triggers faster
    vim.o.updatetime = 300
    -- So that the window doesn't shift around in the presence of
    -- diagnostics
    vim.wo.signcolumn = "yes"

    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { silent = true, noremap =  true }

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', 'ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- XXX Depend on telescope, but only relevant when lsp is actually
    --     enabled, so I place them here instead of at `config.telescope`
    map('n', '<leader>c', '<cmd>Telescope lsp_workspace_diagnostics<CR>', opts)
    map('n', '<leader>C', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
    map('n', '<leader>t', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
    map('n', '<leader>T', '<cmd>Telescope lsp_document_symbols<CR>', opts)
end

require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
})
