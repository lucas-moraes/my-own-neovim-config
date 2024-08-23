local theme = {}

function theme.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "light"

	vim.api.nvim_set_hl(0, "Normal", { fg = "#6e6e6e", bg = "#f3f6f4" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#f3f6f4" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#f3f6f4" })

	-- Indent
	vim.o.list = true

	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#d3d3d3" }) -- cor para os caracteres de espaços e tabulações
	vim.api.nvim_set_hl(0, "NonText", { fg = "#d3d3d3" }) -- cor para caracteres eol, trail, extends, precedes

	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#007AAF", bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#FF9500" })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#007AAF" })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#007AAF" })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#007AAF" })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#ff3b30" })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#dadddb" })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#dadddb" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#6866da", bg = "#f3f6f4" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "#dadddb" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#dadddb" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#6866da", bg = "#dadddb" })

	-- User Interface
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#dadddb" }) -- Linha do cursor
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#ff3b30" }) -- Coluna do cursor
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#dadddb" }) -- Coluna de cores
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#3cad50" }) -- Números de linha
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff3b30" }) -- Número da linha do cursor
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#6866da", bg = "#FF9500" }) -- Linha de status
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#007AAF", bg = "#ff3b30" }) -- Linha de status não ativa
	vim.api.nvim_set_hl(0, "VertSplit", { fg = "#FF9500" }) -- Divisões verticais
	vim.api.nvim_set_hl(0, "TabLine", { fg = "#3cad50", bg = "#ff3b30" }) -- Linha de abas
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#ff3b30", bg = "#f3f6f4" }) -- Preenchimento da linha de abas
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#6866da", bg = "#FF9500" }) -- Aba selecionada

	-- Comentários
	vim.api.nvim_set_hl(0, "Comment", { fg = "#6e6e6e", italic = true })

	-- Strings
	vim.api.nvim_set_hl(0, "String", { fg = "#1c00cf" })
	vim.api.nvim_set_hl(0, "Character", { fg = "#1c00cf" })

	-- Números e Booleans
	vim.api.nvim_set_hl(0, "Number", { fg = "#1c00cf" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#1c00cf" })
	vim.api.nvim_set_hl(0, "Float", { fg = "#1c00cf" })

	-- Variáveis e Identificadores
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#c41a16" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#c41a16" })

	-- Palavras-chave
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#a626a4", bold = true })
	vim.api.nvim_set_hl(0, "Conditional", { fg = "#a626a4", bold = true })
	vim.api.nvim_set_hl(0, "Repeat", { fg = "#a626a4", bold = true })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "Exception", { fg = "#a626a4", bold = true })

	-- Tipos e Classes
	vim.api.nvim_set_hl(0, "Type", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "StorageClass", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "Structure", { fg = "#50a14f" })
	vim.api.nvim_set_hl(0, "Typedef", { fg = "#50a14f" })

	-- Preproc
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "Include", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "Define", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "Macro", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = "#a626a4" })

	-- Constantes
	vim.api.nvim_set_hl(0, "Constant", { fg = "#4078f2" })
	vim.api.nvim_set_hl(0, "TSConstant", { fg = "#4078f2" })
	vim.api.nvim_set_hl(0, "TSConstBuiltin", { fg = "#4078f2" })
	vim.api.nvim_set_hl(0, "TSConstMacro", { fg = "#4078f2" })

	-- React e TypeScript específico
	vim.api.nvim_set_hl(0, "TSXTag", { fg = "#a626a4" })
	vim.api.nvim_set_hl(0, "TSXAttribute", { fg = "#50a14f" })
	vim.api.nvim_set_hl(0, "TSXComponent", { fg = "#c41a16" })
	vim.api.nvim_set_hl(0, "TSXText", { fg = "#000000" })
end

return theme
