-- ======================================================================
-- LSP CONFIGURAÇÃO - NOVA API (Neovim 0.11+)
-- ======================================================================

local lsp = vim.lsp
local api = vim.api
local util = require("lspconfig.util")

-- ======================================================================
-- FUNÇÕES AUXILIARES
-- ======================================================================

local function on_attach(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    api.nvim_create_autocmd("BufWritePre", {
      group = api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        focus = false,
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      })
    end,
  })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function goto_definition_filtered()
  local function filter_node_modules(results)
    if not results then return {} end
    return vim.tbl_filter(function(result)
      local uri = result.uri or result.targetUri
      return not uri:match("node_modules")
    end, results)
  end

  lsp.buf_request(0, "textDocument/definition", lsp.util.make_position_params(), function(err, result)
    if err then
      vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
      return
    end
    local filtered = filter_node_modules(result)
    if vim.tbl_isempty(filtered) then
      vim.notify("Nenhuma definição encontrada fora de node_modules.", vim.log.levels.WARN)
      return
    end
    lsp.util.jump_to_location(filtered[1], "utf-8")
  end)
end

-- ======================================================================
-- CONFIGURAÇÃO DE SERVIDORES
-- ======================================================================

local function setup_server(name, opts)
  local server_defaults = {
    ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
    },
    cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      root_dir = util.root_pattern(".git", vim.fn.getcwd()),
    },
    tailwindcss = {
      cmd = { "tailwindcss-language-server", "--stdio" },
      filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
      root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts", ".git"),
    },
  }

  local server_cfg = vim.tbl_deep_extend("force", server_defaults[name] or {}, opts or {}, {
    name = name,
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config[name] = server_cfg
  vim.lsp.start(server_cfg)
end

-- ======================================================================
-- SERVIDORES
-- ======================================================================

setup_server("ts_ls", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>CodeActionMenu<CR>", opts)
    vim.keymap.set("n", "<leader>gd", goto_definition_filtered, { buffer = bufnr, noremap = true, silent = true })
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  end,
})

setup_server("cssls")
setup_server("tailwindcss")


