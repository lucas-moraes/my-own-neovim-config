local status, formatter = pcall(require, "formatter")

if not status then
	return
end

local rustfmt_config = function()
	return {
		exe = "rustfmt",
		args = { "--edition", "2021" },
		stdin = true,
	}
end

formatter.setup({
	logging = false,
	filetype = {
		rust = { rustfmt_config },
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
	pattern = { "*.rs", "*.lua" },
	command = "FormatWrite",
	group = "FormatAutogroup",
})
