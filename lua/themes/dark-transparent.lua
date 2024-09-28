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

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#582085" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#582085" })

	-- Interface e UI
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2f313e" })
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

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#d7a400", italic = true })
  
  vim.api.nvim_set_hl(0, "Keyword", { fg = "#00a5ff" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#00ff4e" })
	vim.api.nvim_set_hl(0, "Parameter", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "String", { fg = "#f1fa8c" })
	vim.api.nvim_set_hl(0, "Type", { fg = "#f2f2f2" })
	vim.api.nvim_set_hl(0, "Number", { fg = "#ff5555" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#ff5555" })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#00e5ff" })
	vim.api.nvim_set_hl(0, "Comment", { fg = "#6272a4", italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = "#bd93f9" })
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "Error", { fg = "#331111", bold = true, bg = "#ff5555" })
	vim.api.nvim_set_hl(0, "Property", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "Atributes", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "Tag", { fg = "#bf65fa"})
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#00ff4e" })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = "#00e5ff" })
	vim.api.nvim_set_hl(0, "Special", { fg = "#00ff4e" })



end

return theme
