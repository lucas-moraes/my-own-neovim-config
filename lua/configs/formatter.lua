local status, formatter = pcall(require, "formatter")

if not status then
	return
end

local prettier_config = function() 
  return{
    exe = "prettier",
    args = {
      "--stdin-filepath", vim.api.nvim_buf_get_name(0),
			"--tab-width", "2",  -- Ajusta o tamanho da indentação
			"--use-tabs", "false",  -- Usa espaços ao invés de tabs
			"--html-whitespace-sensitivity", "ignore",  -- Ignora espaços em branco no HTML
			"--print-width", "80"
    },
    stdin = true
  }

end

formatter.setup({
	logging = false,
	filetype = {
    python = {
      function()
        return {
          exe = "black",
          args = {"--fast", "-"},
          stdin = true
        }
      end
    },
	},
})

vim.api.nvim_exec(
	[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.css,*.prisma,*.js,*.ts,*.json,*.html,*.scss,*.less,*.md FormatWrite
  augroup END
]],
	true
)
