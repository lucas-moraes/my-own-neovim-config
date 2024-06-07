local status, cmp = pcall(require, "coc")
if not status then
	return
end

vim.g.coc_global_extensions = {
	"coc-html", -- Extensão para HTML
	"coc-css", -- Extensão para CSS
	"coc-phpls", -- Extensão para PHP
	"coc-blade", -- Extensão para Blade
	"coc-prettier", -- Extensão para formatação com Prettier
	"coc-eslint", -- Extensão para ESLint
}

-- Configurações adicionais para o servidor de linguagem PHP e Blade
vim.cmd([[
  autocmd FileType php lua require('coc').config({
    languageserver = {
      php = {
        command = 'php',
        args = {'-dxdebug.mode=off', '/path/to/php-language-server.php'},
        filetypes = {'php', 'blade.php'},
        settings = {
          php = {
            runtime = {
              version = '7.4',
              path = vim.split(package.path, ';')
            },
            diagnostics = {
              enable = true,
              globals = {'vim'}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = {
              enable = false
            }
          }
        }
      }
    }
  })
]])
