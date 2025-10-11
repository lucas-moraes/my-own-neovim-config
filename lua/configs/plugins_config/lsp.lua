local lspconfig = vim.lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()


-- Configuração genérica
local servers = { "ts_ls", "cssls", "html", "lua_ls", "tailwindcss" }

for _, server in ipairs(servers) do
	vim.lsp.start({
		name = "ts_ls",
		cmd = { "typescript-language-server", "--stdio" },
		root_dir = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }),
	})
end
