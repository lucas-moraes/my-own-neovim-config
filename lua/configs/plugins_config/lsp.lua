-- ======================================================================
-- LSP CONFIGURAÇÃO - NOVA API (Neovim 0.11+)
-- ======================================================================

local lsp = vim.lsp
local api = vim.api

-- ======================================================================
-- FUNÇÕES AUXILIARES
-- ======================================================================

-- Função chamada quando o servidor LSP é anexado ao buffer
local function on_attach(client, bufnr)
  -- Formatar ao salvar
  if client.server_capabilities.documentFormattingProvider then
    api.nvim_create_autocmd("BufWritePre", {
      group = api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- Mostrar diagnósticos ao parar o cursor
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

-- Capabilities padrão (para integração com nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Função para ignorar node_modules nas definições
local function goto_definition_filtered()
  local util = lsp.util

  local function filter_node_modules(results)
    if not results then
      return {}
    end
    return vim.tbl_filter(function(result)
      local uri = result.uri or result.targetUri
      return not uri:match("node_modules")
    end, results)
  end

  lsp.buf_request(0, "textDocument/definition", util.make_position_params(), function(err, result, ctx, _)
    if err then
      vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
      return
    end

    local filtered = filter_node_modules(result)
    if vim.tbl_isempty(filtered) then
      vim.notify("Nenhuma definição encontrada fora de node_modules.", vim.log.levels.WARN)
      return
    end

    util.jump_to_location(filtered[1], "utf-8")
  end)
end

-- ======================================================================
-- FUNÇÃO DE CONFIGURAÇÃO DE SERVIDORES
-- ======================================================================

local function setup_server(opts)
  local config = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, opts)

  local lspconfig = require("lspconfig")  -- ainda necessário apenas para pegar o cmd/root_dir
  local server_cfg = lspconfig[config.name].document_config.default_config

  lsp.start(lsp.config({
    name = config.name,
    cmd = server_cfg.cmd,
    root_dir = server_cfg.root_dir,
    filetypes = server_cfg.filetypes,
    settings = config.settings,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  }))
end

-- ======================================================================
-- SERVIDORES LSP
-- ======================================================================

-- JavaScript / TypeScript
setup_server({
  name = "ts_ls",
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>CodeActionMenu<CR>", opts)
    vim.keymap.set("n", "<leader>gd", goto_definition_filtered, { buffer = bufnr, noremap = true, silent = true })
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  end,
})

-- CSS
setup_server({ name = "cssls" })

-- TailwindCSS
setup_server({ name = "tailwindcss" })

