require('lspkind').init({ with_text = true })

require('lspsaga').init_lsp_saga({
    use_saga_diagnostic_sign = false
})

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { silent = true, noremap =  true }

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
})
