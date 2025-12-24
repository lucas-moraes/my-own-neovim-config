---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
	vim.o.termguicolors = true
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	local moon = {
		bg = "#1e2030",
		fg = "#c8d3f5",
		comment = "#7a88cf",
		red = "#ff757f",
		orange = "#ff966c",
		yellow = "#ffc777",
		green = "#c3e88d",
		cyan = "#86e1fc",
		blue = "#82aaff",
		magenta = "#c099ff",
		black = "#1b1d2b",
		white = "#c8d3f5",
		gray = "#444a73",
	}

	vim.api.nvim_set_hl(0, "Normal", { bg = moon.bg, fg = moon.fg })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = moon.bg })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = moon.bg, bg = moon.bg })

	vim.o.list = true
	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
	vim.api.nvim_set_hl(0, "Whitespace", { fg = moon.black })
	vim.api.nvim_set_hl(0, "NonText", { fg = moon.gray })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = moon.black })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = moon.black })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = moon.black })
	vim.api.nvim_set_hl(0, "LineNr", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = moon.white, bg = moon.gray })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = moon.gray, bg = moon.black })
	vim.api.nvim_set_hl(0, "TabLine", { fg = moon.white, bg = moon.black })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = moon.black })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = moon.white, bg = moon.gray })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = moon.gray })

	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = moon.blue, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = moon.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = moon.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = moon.white })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = moon.green })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = moon.yellow })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = moon.red })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = moon.red })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = moon.white, bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = moon.black })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = moon.cyan })

	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = moon.gray, italic = true })

	vim.api.nvim_set_hl(0, "Keyword", { fg = moon.magenta })
	vim.api.nvim_set_hl(0, "Function", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "Parameter", { fg = moon.white })
	vim.api.nvim_set_hl(0, "String", { fg = moon.green })
	vim.api.nvim_set_hl(0, "Type", { fg = moon.yellow })
	vim.api.nvim_set_hl(0, "Number", { fg = moon.orange })
	vim.api.nvim_set_hl(0, "Boolean", { fg = moon.orange })
	vim.api.nvim_set_hl(0, "Operator", { fg = moon.blue })
	vim.api.nvim_set_hl(0, "Comment", { fg = moon.comment, italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "PreProc", { fg = moon.yellow })
	vim.api.nvim_set_hl(0, "Error", { fg = moon.bg, bg = moon.red, bold = true })
	vim.api.nvim_set_hl(0, "Property", { fg = moon.white })
	vim.api.nvim_set_hl(0, "Atributes", { fg = moon.white })
	vim.api.nvim_set_hl(0, "Tag", { fg = moon.magenta })
	vim.api.nvim_set_hl(0, "Identifier", { fg = moon.blue })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "Special", { fg = moon.cyan })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "Ibl", { fg = moon.gray })
	vim.api.nvim_set_hl(0, "IblScope", { fg = moon.cyan, bold = true })
end

return theme
