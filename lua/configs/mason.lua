local status_mason, mason = pcall(require, "mason")
local status_mason_lsp, masonlsp = pcall(require, "mason-lspconfig")

if not status_mason then
	return
end

mason.setup()

masonlsp.setup({
	automatic_installation = true,
	ensure_installed = {
		"cssls",
		"eslint",
		"html",
		"jsonls",
		"tsserver",
		"pyright",
		"tailwindcss",
	},
})
