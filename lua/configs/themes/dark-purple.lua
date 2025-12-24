---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
	vim.o.termguicolors = true
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	vim.api.nvim_set_hl(0, "Normal", { bg = "#1e1b29" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1e1b29" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#1e1b29" })

	vim.o.list = true
	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "NonText", { fg = "#3a2d4a" })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2340" })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#8b5fbf" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#bf80ff", bg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#bf80ff", bg = "#2a2340" })
	vim.api.nvim_set_hl(0, "TabLine", { fg = "#d1c0f0", bg = "#2a2340" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#2a2340" })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#d1c0f0", bg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#bf80ff", bg = "none" })

	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#cfa9f7", bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#e4dbf9" })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#a77cbf" })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#a77cbf" })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#a77cbf" })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#a037bf" })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#cfa9f7", bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#3a2d4a" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#cfa9f7", bg = "none" })

	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#8f5fbf", italic = true })

	vim.api.nvim_set_hl(0, "Keyword", { fg = "#a37bff" })
	vim.api.nvim_set_hl(0, "Function", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "Parameter", { fg = "#d1c0f0" })
	vim.api.nvim_set_hl(0, "String", { fg = "#e6ccff" })
	vim.api.nvim_set_hl(0, "Type", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "Number", { fg = "#a037bf" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = "#a037bf" })
	vim.api.nvim_set_hl(0, "Operator", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "Comment", { fg = "#8b5fbf", italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = "#cfa9f7" })
	vim.api.nvim_set_hl(0, "PreProc", { fg = "#a37bff" })
	vim.api.nvim_set_hl(0, "Error", { fg = "#e0115f", bold = true, bg = "#7a2973" })
	vim.api.nvim_set_hl(0, "Property", { fg = "#a37bff" })
	vim.api.nvim_set_hl(0, "Atributes", { fg = "#a37bff" })
	vim.api.nvim_set_hl(0, "Tag", { fg = "#b05fbf" })
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = "#a37bff" })
	vim.api.nvim_set_hl(0, "Special", { fg = "#bf80ff" })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = "#8b5fbf" })
	vim.api.nvim_set_hl(0, "Ibl", { fg = "#8b5fbf" })
	vim.api.nvim_set_hl(0, "IblScope", { fg = "#a037bf", bold = true })
end

return theme
