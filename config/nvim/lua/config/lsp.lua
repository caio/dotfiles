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
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', 'ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', '<leader>t', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    map('n', '<leader>T', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

    local cmd = vim.api.nvim_command
    -- Format right before saving
    cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

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
    cmd = {"rustup", "run", "stable", "rust-analyzer"},
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
    cmd = {
        'gopls',
        '-remote=auto',
    },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          nilness = true,
          shadow = true,
          unusedwrite = true,
        },
        staticcheck = true,
      },
    },
})
