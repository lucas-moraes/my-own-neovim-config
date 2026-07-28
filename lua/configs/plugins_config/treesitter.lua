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
		"python",
		"rst",
		"toml",
		"markdown",
		"lua",
		"json",
		"yaml",
	},
	incremental_selection = { enable = true },
	indent = { enable = true },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
