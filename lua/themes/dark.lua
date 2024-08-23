local theme = {}

function theme.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	-- Define highlights
	vim.api.nvim_set_hl(0, "Normal", { bg = "#130f26" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#130f26" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#130f26" })

	-- Indent
	vim.o.list = true

	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#281f4f" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#281f4f" })

	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#a093d8", bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#FF9500" })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#a093d8" })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#a093d8" })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#cfc9eb" })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#3cad50" })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#ff3b30" })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#281f4f" })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#a093d8" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#6866da", bg = "#130f26" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#281f4f" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#6866da", bg = "#130f26" })

	-- User Interface
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#261e4c" }) -- Linha do cursor
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3a2d72" }) -- Coluna do cursor
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#261e4c" }) -- Coluna de cores
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#433585" }) -- Números de linha
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fdff00" }) -- Número da linha do cursor
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#6866da", bg = "#FF9500" }) -- Linha de status
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#007AAF", bg = "#ff3b30" }) -- Linha de status não ativa
	vim.api.nvim_set_hl(0, "VertSplit", { fg = "#FF9500" }) -- Divisões verticais
	vim.api.nvim_set_hl(0, "TabLine", { fg = "#3cad50", bg = "#ff3b30" }) -- Linha de abas
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#ff3b30", bg = "NONE" }) -- Preenchimento da linha de abas
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#6866da", bg = "#FF9500" }) -- Aba selecionada

	-- Comentários
	vim.api.nvim_set_hl(0, "Comment", { fg = "#6272a4", italic = true })

	-- Strings
	vim.api.nvim_set_hl(0, "String", { fg = "#f1fa8c" })
	vim.api.nvim_set_hl(0, "Character", { fg = "#f1fa8c" })

	-- Números e Booleans
	vim.api.nvim_set_hl(0, "Number", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "Float", { fg = "#bd93f9" })

	-- Variáveis e Identificadores
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#50fa7b" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#50fa7b" })

	-- Palavras-chave
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "Conditional", { fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "Repeat", { fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "Exception", { fg = "#ff79c6", bold = true })

	-- Tipos e Classes
	vim.api.nvim_set_hl(0, "Type", { fg = "#8be9fd" })
	vim.api.nvim_set_hl(0, "StorageClass", { fg = "#8be9fd" })
	vim.api.nvim_set_hl(0, "Structure", { fg = "#8be9fd" })
	vim.api.nvim_set_hl(0, "Typedef", { fg = "#8be9fd" })

	-- Preproc
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "Include", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "Define", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "Macro", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = "#ff79c6" })

	-- Constantes
	vim.api.nvim_set_hl(0, "Constant", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "TSConstant", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "TSConstBuiltin", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "TSConstMacro", { fg = "#bd93f9" })

	-- React e TypeScript específico
	vim.api.nvim_set_hl(0, "TSXTag", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "TSXAttribute", { fg = "#8be9fd" })
	vim.api.nvim_set_hl(0, "TSXComponent", { fg = "#50fa7b" })
	vim.api.nvim_set_hl(0, "TSXText", { fg = "#f8f8f2" })
end

return theme
