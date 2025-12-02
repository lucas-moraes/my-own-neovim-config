local status, formatter = pcall(require, "formatter")

if not status then
	return
end

local prettier_config = function() 
  return{
    exe = "npx",
    args = {
      "prettier",
      string.format("--stdin-filepath=%s", vim.api.nvim_buf_get_name(0)),
			"--tab-width", "2", 
			"--use-tabs", "false",
			"--html-whitespace-sensitivity", "ignore",
      "--print-width", "120"
    },
    stdin = true
  }

end

formatter.setup({
	logging = false,
	filetype = {
   python = {
        pylsp = {
            command = "pylsp",
            args = { "--stdio", "--format" },
            stdin = true
        }
    },
    json = { prettier_config },
    markdown = { prettier_config },
    lua = {
      stylua = {
        command = "stylua",
        args = { "--search-parent-directories", "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--" },
        stdin = true,
      },
    },
	},
})

vim.api.nvim_exec(
	[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.json,*.html,*.md,*.py,*.lua FormatWrite
  augroup END
]],
	true
)
