local status_mason, mason = pcall(require, "mason")
local status_mason_lsp, masonlsp = pcall(require, "mason-lspconfig")
local status_mason_tool, masontool = pcall(require, "mason-tool-installer")

if not status_mason then
	return
end

if not status_mason_lsp then
	return
end

if not status_mason_tool then
	return
end

mason.setup()

masonlsp.setup({
	automatic_installation = true,
})

masontool.setup({
	ensure_installed = {
		"css-lsp",
		"html-lsp",
		"js-debug-adapter",
		"json-lsp",
		"typescript-language-server",
		"stylua",
	},
	auto_update = true,
	run_on_start = true,
	timeout = 300,
	debounce_hours = 24,
})
