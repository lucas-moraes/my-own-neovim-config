local theme = {}

theme.base0A = "#dadddb"
theme.base0B = "#ccccf2"
theme.base00 = "#f3f6f4"
theme.base01 = "#ff3b30"
theme.base02 = "#FF9500"
theme.base03 = "#3cad50"
theme.base04 = "#007AAF"
theme.base05 = "#6866da"
theme.base06 = "#abaaea"
theme.base07 = "#2c2b6b"

function theme.setup()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "light"

	-- Define highlights
	vim.api.nvim_set_hl(0, "Normal", { bg = "#fffef5" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#f3f6f4" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "Comment", { fg = "#abaaea", italic = true })
	-- constants
	vim.api.nvim_set_hl(0, "Constant", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "String", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "Character", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "Number", { fg = "#FF9500" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#FF9500" })
	vim.api.nvim_set_hl(0, "Float", { fg = "#FF9500" })
	-- indicators
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#6866da" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#6866da" })
	vim.api.nvim_set_hl(0, "TSFunction", { fg = "#6866da" })
	vim.api.nvim_set_hl(0, "TSMethod", { fg = "#6866da" })
	vim.api.nvim_set_hl(0, "TSConstructor", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TSParameter", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TSParameterReference", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TSVariable", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TSVariableBuiltin", { fg = "#61afef" })

	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = theme.base04, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = theme.base02 })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = theme.base04 })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = theme.base04 })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = theme.base04 })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = theme.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = theme.base01 })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = theme.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = theme.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = theme.base0A })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = theme.base0A })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = theme.base05, bg = theme.base00 })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = theme.base0A })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = theme.base0A })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = theme.base05, bg = theme.base0A })

	-- User Interface
	vim.api.nvim_set_hl(0, "CursorLine", { bg = theme.base0A }) -- Linha do cursor
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = theme.base01 }) -- Coluna do cursor
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = theme.base0A }) -- Coluna de cores
	vim.api.nvim_set_hl(0, "LineNr", { fg = theme.base03 }) -- Números de linha
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = theme.base01 }) -- Número da linha do cursor
	vim.api.nvim_set_hl(0, "StatusLine", { fg = theme.base05, bg = theme.base02 }) -- Linha de status
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = theme.base04, bg = theme.base01 }) -- Linha de status não ativa
	vim.api.nvim_set_hl(0, "VertSplit", { fg = theme.base02 }) -- Divisões verticais
	vim.api.nvim_set_hl(0, "TabLine", { fg = theme.base03, bg = theme.base01 }) -- Linha de abas
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = theme.base01, bg = theme.base00 }) -- Preenchimento da linha de abas
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = theme.base05, bg = theme.base02 }) -- Aba selecionada
end

return theme
