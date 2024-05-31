-- Carregar o plugin Kanagawa de forma segura
vim.opt.termguicolors = true

local status, kanagawa = pcall(require, "kanagawa")

if not status then
	return
end

-- Configurar o tema Kanagawa
kanagawa.setup({
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	variablebuiltinStyle = { italic = true },
	specialReturn = true, -- special highlight for the return keyword
	specialException = true, -- special highlight for exception handling keywords
	transparent = true, -- definir background transparente
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	globalStatus = false, -- adjust window separators highlight for laststatus=3
	theme = "dragon", -- Load "default" theme or the experimental "light" theme
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	overrides = function(colors)
		return {
			-- Example override: change the background color of Normal
			Normal = { bg = colors.bg },
		}
	end,
})

vim.cmd("colorscheme kanagawa")
