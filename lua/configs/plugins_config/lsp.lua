---@diagnostic disable: undefined-global

vim.lsp.start({
	name = "lua_ls",
	cmd = { "lua-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { ".git" }),
})

vim.lsp.start({
    name = "pylsp",
    cmd = { "pylsp" },
    root_dir = vim.fs.root(0, { ".git", "setup.py" }),
    settings = {
        pylsp = {
            configurationSources = { "pycodestyle" },
            formatCommand = "<pylsp.plugins.black>",
            plugins = {
                jedi_completion = { enabled = true },
                jedi_hover = { enabled = true },
                black = { enabled = true },
                pylint = { enabled = true },
                flake8 = { enabled = true },
                pydocstyle = { enabled = false },
            }
        }
    },
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = bufnr })
        print("pylsp conectado com sucesso!")
    end
})

-- Instalação do LSP e dos seus plugins (Linters/Formatters)
-- RUN pip install \
--    pylsp \
--    python-lsp-server[pylint] \
--    python-lsp-server[flake8] \
--    python-lsp-server[pydocstyle] \
--    black \
--    isort
