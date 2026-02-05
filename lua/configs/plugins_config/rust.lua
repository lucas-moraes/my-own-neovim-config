local status_rt, rt = pcall(require, "rust-tools")
if not status_rt then
  return
end

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Rust-tools specific keybindings
  vim.keymap.set("n", "K", rt.hover_actions.hover_actions, opts)
  vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, opts)

  -- Standard LSP keybindings
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

  -- Rust-tools specific commands
  vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
  vim.keymap.set("n", "<leader>rd", rt.debuggables.debuggables, opts)
  vim.keymap.set("n", "<leader>rc", rt.open_cargo_toml.open_cargo_toml, opts)
  vim.keymap.set("n", "<leader>rp", rt.parent_module.parent_module, opts)
  vim.keymap.set("n", "<leader>rm", rt.expand_macro.expand_macro, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Codelldb setup for debugging
local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
local codelldb_path = nil
local liblldb_path = nil

if mason_registry_ok and mason_registry.is_installed("codelldb") then
  local codelldb = mason_registry.get_package("codelldb")
  local extension_path = codelldb:get_install_path() .. "/extension/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
end

-- Fallback paths
if not codelldb_path then
  codelldb_path = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb")
  liblldb_path = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib")
end

local dap_config = nil
if vim.fn.filereadable(codelldb_path) == 1 then
  dap_config = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  }
end

rt.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--all-targets", "--all-features", "--", "-D", "warnings" },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
        inlayHints = {
          bindingModeHints = { enable = true },
          chainingHints = { enable = true },
          closingBraceHints = { enable = true },
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = { enable = "always" },
          lifetimeElisionHintsUseParameterNames = { enable = true },
          maxLength = 25,
          parameterHints = { enable = true },
          reborrowHints = { enable = "always" },
          typeHints = { enable = true },
        },
      },
    },
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
    },
  },
  dap = dap_config,
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
