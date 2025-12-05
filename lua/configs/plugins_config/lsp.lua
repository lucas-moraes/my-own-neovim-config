---@diagnostic disable: undefined-global

local root_dir = vim.fs.root(0, { "pyproject.toml", ".git", ".editorconfig" })

local pylsp_settings = {
    pylsp = {
        plugins = {
            black = { enabled = true },
            isort = { enabled = true },
            pycodestyle = { enabled = true },
            pylint = { enabled = false },
        }
    }
}

vim.lsp.start({
    name = "pylsp",
    cmd = { "python-lsp-server" },
    args = { "--stdio" },
    root_dir = root_dir,
    settings = pylsp_settings,

    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd.autocmd('BufWritePre', '<buffer>', 'lua vim.lsp.buf.format({ async = true })')
        end
    end,
})
