---@diagnostic disable: undefined-global

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
})

local ts_settings = {
  preferences = {
    includeCompletionsForModuleExports = true,
    includeCompletionsWithInsertText = true,
    includePackageJsonAutoImports = "auto",
    importModuleSpecifierPreference = "non-relative",
  },
  suggest = {
    autoImports = true,
    includeCompletionsForImportStatements = true,
    completeFunctionCalls = true,
  },
}

vim.lsp.config("ts_ls", {
  settings = {
    typescript = ts_settings,
    javascript = ts_settings,
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
