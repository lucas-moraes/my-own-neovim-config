local theme = {}

function theme.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	-- Define highlights
	vim.api.nvim_set_hl(0, "Normal", { bg = "#1f1b17" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1f1b17" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#1f1b17" })

	-- Indent
	vim.o.list = true

	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3a2d22" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#3a2d22" })

	-- Interface e UI
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2c251b" })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3a2d22" })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3a2d22" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffb84d" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffaf40" })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ff9500", bg = "#3a2d22" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#ff9500", bg = "#2c251b" })
	vim.api.nvim_set_hl(0, "TabLine", { fg = "#ffebcc", bg = "#2c251b" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#2c251b" })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#ffebcc", bg = "#3a2d22" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ff8c00", bg = "none" })

	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#ffcc80", bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#FF9500" })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#ffcc80" })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#ffcc80" })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#ffebcc" })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#ff4500" })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#2c251b" })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#ffcc80" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#ffcc80", bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2c251b" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#ffcc80", bg = "none" })

	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#b25900", italic = true })

	vim.api.nvim_set_hl(0, "Keyword", { fg = "#ff8000" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "Parameter", { fg = "#ffcc80" })
	vim.api.nvim_set_hl(0, "String", { fg = "#ffeb99" })
	vim.api.nvim_set_hl(0, "Type", { fg = "#ffcc80" })
	vim.api.nvim_set_hl(0, "Number", { fg = "#ff4500" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#ff4500" })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "Comment", { fg = "#b25900", italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = "#ffaf40" })
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "Error", { fg = "#331111", bold = true, bg = "#ff4500" })
	vim.api.nvim_set_hl(0, "Property", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "Atributes", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "Tag", { fg = "#ff8000" })
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#ffa500" })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = "#ff9500" })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = "#ff8c00" })
	vim.api.nvim_set_hl(0, "Special", { fg = "#ffa500" })
end

return theme

