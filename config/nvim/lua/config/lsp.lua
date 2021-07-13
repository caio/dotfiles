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
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', 'ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- Show a pop-up with the line diagnostic details
    map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    map('n', '<leader>d', '<cmd>Telescope lsp_workspace_diagnostics<CR>', opts)
    map('n', '<leader>D', '<cmd>Telescope lsp_document_diagnostics<CR>', opts)
    map('n', '<leader>t', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
    map('n', '<leader>T', '<cmd>Telescope lsp_document_symbols<CR>', opts)

    local cmd = vim.api.nvim_command
    -- Format right before saving
    -- XXX Only for `*.rs`, make it for `*` calling something that checks
    --     capabilities or smth
    cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync()]])

    -- Highlight current "word" under cursor
    cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    -- And clear the highlight after move
    cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                spacing = "2",
                -- Do NOT show inline diagnostics unless they are errors
                severity_limit = "Error",
            },
        }
    )

    -- TODO vim.lsp.codelens.run() calls 'workspace/executeCommand' via RPC
    --      and rust-analyzer will not support it. I do want the "run this
    --      test" and "run all tests" functionality, but not the "X references"
    --      thing that other LSP servers implement.
end

require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    }
})
