local status, formatter = pcall(require, "formatter")

if not status then
	return
end

local ruff_format = function()
	return {
		exe = "ruff",
		args = {
			"format",
			"--stdin-filename",
			vim.api.nvim_buf_get_name(0),
			"-",
		},
		stdin = true,
	}
end

formatter.setup({
	logging = false,
	filetype = {
		python = { ruff_format },
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},
})

vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.lua", "*.py" },
	command = "FormatWrite",
	group = "FormatAutogroup",
})
