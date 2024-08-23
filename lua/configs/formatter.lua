local status, formatter = pcall(require, "formatter")

if not status then
	return
end

formatter.setup({
	logging = false,
	filetype = {
		javascript = {
			-- biome
			function()
				return {
					exe = "biome",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		typescript = {
			-- biome
			function()
				return {
					exe = "biome",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		json = {
			-- biome
			function()
				return {
					exe = "biome",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		html = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		css = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		scss = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		less = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		markdown = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		prisma = {
			function()
				return {
					exe = "prisma",
					args = { "format", "--schema", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end,
		},
	},
})

-- autocomando para formatar ao salvar
vim.api.nvim_exec(
	[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.css FormatWrite
  augroup END
]],
	true
)

vim.api.nvim_exec(
	[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.prisma FormatWrite
  augroup END
]],
	true
)
