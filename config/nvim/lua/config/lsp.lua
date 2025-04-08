vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        -- Run cursor+timer triggers faster
        vim.o.updatetime = 300
        -- So that the window doesn't shift around in the presence of diagnostics
        vim.wo.signcolumn = "yes"

        -- ^]: definition (^T: jump back)
        -- gri: implementation
        -- grr: references
        -- grn: rename
        -- gra: code_action
        local function nmap(seq, action)
            local opts = { silent = true, noremap = true}
            vim.api.nvim_buf_set_keymap(args.buf, 'n', seq, string.format("<cmd>%s<CR>", action), opts)
        end
        nmap('gy', 'lua vim.lsp.buf.type_definition()')
        nmap('<leader>s', 'Telescope lsp_document_symbols')
        nmap('<leader>S', 'Telescope lsp_dynamic_workspace_symbols')

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true
            })
        end

        if client:supports_method('textDocument/foldingRange') then
            vim.o.foldlevel = 99
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        local group = vim.api.nvim_create_augroup('my.lsp', {clear=false})

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = group,
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end

        if client:supports_method('textDocument/documentHighlight') then
            vim.api.nvim_create_autocmd('CursorHold', {
                group = group,
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = group,
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
            })
        end

    end,
})

vim.lsp.config('*', {
    root_markers = { ".git" },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false
                }
            }
        }
    }
})

vim.lsp.config("rust_analyzer", {
    cmd = {"rustup", "run", "stable", "rust-analyzer"},
    filetypes = { "rust" },
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

vim.lsp.config("gopls", {
    cmd = {
        "gopls",
        "-remote=auto",
    },
    root_markers = { "go.mod" },
    filetypes = { "go" },
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
    }
})

local function home_cache_dir(tail)
  local base = vim.env.XDG_CACHE_HOME
  if not base and vim.env.HOME then
    base = vim.env.HOME .. "/.cache"
  end
  -- fallback to a hidden dir on cwd
  if not base then
    return '.' .. tail
  end

  return base .. '/' .. tail
end

vim.lsp.config("ccls", {
    cmd = { "ccls" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { "compile_commands.json" },
    init_options = {
        cache = {
            directory = home_cache_dir('ccls'),
        },
    },
})

vim.api.nvim_create_user_command("LspStart", function()
    vim.lsp.enable({"rust_analyzer", "gopls", "ccls"})
    vim.cmd("edit") -- reload buffer
end, {})
