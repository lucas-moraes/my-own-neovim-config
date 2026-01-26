---@diagnostic disable: undefined-global

local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	folding = {
		enable = true,
	},
	ensure_installed = {
		"markdown",
		"tsx",
		"typescript",
		"javascript",
		"toml",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		"php",
		"python",
	},
	incremental_selection = { enable = true },
	indent = { enable = true },
})

-- Configuração para foldmethod usando Treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
