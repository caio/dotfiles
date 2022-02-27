local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Run cursor+timer triggers faster
    vim.o.updatetime = 300
    -- So that the window doesn't shift around in the presence of
    -- diagnostics
    vim.wo.signcolumn = "yes"

    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { silent = true, noremap =  true }

    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    map('n', 'gD', '<cmd>Telescope lsp_implementations<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    map('n', 'ac', '<cmd>Telescope lsp_code_actions<CR>', opts)
    map('n', '<leader>t', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
    map('n', '<leader>T', '<cmd>Telescope lsp_document_symbols<CR>', opts)

    local cmd = vim.api.nvim_command
    -- Format right before saving
    -- FIXME Warty
    cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync()]])
    cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]])

    -- Highlight current "word" under cursor
    cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    -- And clear the highlight after move
    cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
end

local config = require('lspconfig')

config.rust_analyzer.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
            },
        },
    }
})

config.gopls.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
})
