local theme = {}

function theme.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	-- Define highlights
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

	-- Indent
	vim.o.list = true

	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#281f4f" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#281f4f" })

	-- Interface e UI
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#44475a" })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#44475a" })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#44475a" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#6272a4" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f1fa8c" })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ff9500", bg = "#44475a" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#ff9500", bg = "#282a36" })
	vim.api.nvim_set_hl(0, "TabLine", { fg = "#f8f8f2", bg = "#282a36" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#282a36" })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#f8f8f2", bg = "#44475a" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#bd93f9", bg = "none" })

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
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#6866da", bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#281f4f" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#6866da", bg = "none" })

	-- Definição de destaques para TypeScript
	-- Palavras-chave (ex.: const, let, async, function)
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#ff79c6", bold = true })

	-- Funções
	vim.api.nvim_set_hl(0, "Function", { fg = "#50fa7b", bold = true })

	-- Variáveis e identificadores
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#8be9fd" })

	-- Parâmetros de função
	vim.api.nvim_set_hl(0, "Parameter", { fg = "#f1fa8c" })

	-- Strings
	vim.api.nvim_set_hl(0, "String", { fg = "#f1fa8c" })

	-- Tipos (ex.: number, string, boolean)
	vim.api.nvim_set_hl(0, "Type", { fg = "#bd93f9" })

	-- Números
	vim.api.nvim_set_hl(0, "Number", { fg = "#bd93f9" })

	-- Booleanos
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#bd93f9" })

	-- Operadores (ex.: +, -, *, /, etc.)
	vim.api.nvim_set_hl(0, "Operator", { fg = "#ff79c6" })

	-- Delimitadores e pontuações (parênteses, chaves, colchetes)
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = "#f8f8f2" })
	vim.api.nvim_set_hl(0, "PunctuationDelimiter", { fg = "#f8f8f2" })

	-- Comentários
	vim.api.nvim_set_hl(0, "Comment", { fg = "#6272a4", italic = true })

	-- Constantes (ex.: true, false, null)
	vim.api.nvim_set_hl(0, "Constant", { fg = "#bd93f9" })

	-- Pré-processadores (ex.: imports, defines)
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#ff79c6" })

	-- Erros
	vim.api.nvim_set_hl(0, "Error", { fg = "#ff5555", bold = true, undercurl = true })

	-- Atributos JSX/TSX
	vim.api.nvim_set_hl(0, "TSXAttribute", { fg = "#8be9fd" })

	-- Texto JSX
	vim.api.nvim_set_hl(0, "TSXText", { fg = "#f8f8f2" })

	-- Texto JSX dentro de tags (por exemplo: <div>texto aqui</div>)
	vim.api.nvim_set_hl(0, "TSXTag", { fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "TSXTagName", { fg = "#50fa7b", bold = true })

	-- Propriedades de objetos
	vim.api.nvim_set_hl(0, "Property", { fg = "#ffa500" })
end

return theme
