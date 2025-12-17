local theme = {}

function theme.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	-- Define o fundo como "light"
	vim.o.background = "light"

	-- Paleta baseada no Dracula, adaptada para o modo claro
	local dracula_light = {
		-- Cores invertidas
		bg = "#f8f9fd", -- Branco claro (o antigo fg)
		fg = "#282a36", -- Preto escuro (o antigo bg)

		-- Cores de destaque ajustadas para fundo claro
		comment = "#8a94b4", -- Um cinza/azul mais escuro para o comentário
		red = "#ff5555",
		orange = "#c27c34", -- Laranja escurecido para melhor contraste
		yellow = "#b59b00", -- Amarelo mais escuro para melhor contraste
		green = "#2d984d", -- Verde mais escuro para melhor contraste
		cyan = "#008197", -- Ciano mais escuro para melhor contraste
		blue = "#4d5b7a", -- Azul mais escuro
		magenta = "#7d47c2", -- Magenta mais escuro
		pink = "#c53b7c", -- Rosa mais escuro (quase bordô)
		black = "#d0d0d0", -- Cinza claro para elementos de interface
		white = "#282a36", -- O antigo fundo (agora o fg principal)
		gray = "#e8e8e8", -- Um cinza muito claro para fundos secundários
		light_gray = "#f0f0f0", -- Um cinza muito claro para linha do cursor
	}

	-- Fundo principal
	vim.api.nvim_set_hl(0, "Normal", { bg = dracula_light.bg, fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = dracula_light.bg })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = dracula_light.bg, bg = dracula_light.bg })

	-- Espaços e invisíveis
	vim.o.list = true
	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
	vim.api.nvim_set_hl(0, "Whitespace", { fg = dracula_light.black }) -- Usando 'black' (cinza claro)
	vim.api.nvim_set_hl(0, "NonText", { fg = dracula_light.black })

	-- Interface
--	vim.api.nvim_set_hl(0, "Cursor", { fg = dracula_light.black, bg = dracula_light.pink })
--	vim.api.nvim_set_hl(0, "CursorIM", { fg = dracula_light.black, bg = dracula_light.pink })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = dracula_light.light_gray })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = dracula_light.light_gray })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = dracula_light.light_gray })
	vim.api.nvim_set_hl(0, "LineNr", { fg = dracula_light.comment })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dracula_light.orange }) -- Mantendo um destaque
	vim.api.nvim_set_hl(0, "StatusLine", { fg = dracula_light.fg, bg = dracula_light.gray, bold = true })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = dracula_light.comment, bg = dracula_light.light_gray })
	vim.api.nvim_set_hl(0, "TabLine", { fg = dracula_light.fg, bg = dracula_light.gray })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = dracula_light.gray })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = dracula_light.bg, bg = dracula_light.pink, bold = true })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = dracula_light.black })

	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = dracula_light.magenta, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = dracula_light.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = dracula_light.green })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = dracula_light.orange })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = dracula_light.red })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = dracula_light.red })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = dracula_light.black })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = dracula_light.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = dracula_light.fg, bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = dracula_light.light_gray })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = dracula_light.pink })

	-- Gitsigns
	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = dracula_light.comment, italic = true })

	-- Código
	vim.api.nvim_set_hl(0, "Keyword", { fg = dracula_light.pink })
	vim.api.nvim_set_hl(0, "Function", { fg = dracula_light.green })
	vim.api.nvim_set_hl(0, "Parameter", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "String", { fg = dracula_light.yellow })
	vim.api.nvim_set_hl(0, "Type", { fg = dracula_light.cyan })
	vim.api.nvim_set_hl(0, "Number", { fg = dracula_light.orange })
	vim.api.nvim_set_hl(0, "Boolean", { fg = dracula_light.orange })
	vim.api.nvim_set_hl(0, "Operator", { fg = dracula_light.magenta })
	vim.api.nvim_set_hl(0, "Comment", { fg = dracula_light.comment, italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = dracula_light.cyan })
	vim.api.nvim_set_hl(0, "PreProc", { fg = dracula_light.pink })
	vim.api.nvim_set_hl(0, "Error", { fg = dracula_light.bg, bg = dracula_light.red, bold = true })
	vim.api.nvim_set_hl(0, "Property", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "Atributes", { fg = dracula_light.fg })
	vim.api.nvim_set_hl(0, "Tag", { fg = dracula_light.magenta })
	vim.api.nvim_set_hl(0, "Identifier", { fg = dracula_light.magenta })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = dracula_light.blue })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = dracula_light.blue })
	vim.api.nvim_set_hl(0, "Special", { fg = dracula_light.cyan })
end

return theme
