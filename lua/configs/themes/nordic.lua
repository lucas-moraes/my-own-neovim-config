---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
	vim.o.termguicolors = true
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	local nord = {
		bg = "#242933",
		fg = "#d8dee9",
		comment = "#616e88",
		red = "#bf616a",
		orange = "#d08770",
		yellow = "#ebcb8b",
		green = "#a3be8c",
		cyan = "#88c0d0",
		blue = "#5e81ac",
		magenta = "#b48ead",
		black = "#3b4252",
		white = "#eceff4",
		gray = "#4c566a",
	}

	vim.api.nvim_set_hl(0, "Normal", { bg = nord.bg, fg = nord.fg })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = nord.bg })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = nord.bg, bg = nord.bg })

	vim.o.list = true
	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
	vim.api.nvim_set_hl(0, "Whitespace", { fg = nord.black })
	vim.api.nvim_set_hl(0, "NonText", { fg = nord.black })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = nord.black })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = nord.black })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = nord.black })
	vim.api.nvim_set_hl(0, "LineNr", { fg = nord.gray })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = nord.white, bg = nord.gray })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = nord.gray, bg = nord.black })
	vim.api.nvim_set_hl(0, "TabLine", { fg = nord.white, bg = nord.black })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = nord.black })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = nord.white, bg = nord.gray })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = nord.gray })

	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = nord.blue, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = nord.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = nord.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = nord.white })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = nord.green })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = nord.yellow })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = nord.red })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = nord.red })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = nord.black })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = nord.white, bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = nord.black })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = nord.cyan })

	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = nord.gray, italic = true })

	vim.api.nvim_set_hl(0, "Keyword", { fg = nord.magenta })
	vim.api.nvim_set_hl(0, "Function", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "Parameter", { fg = nord.white })
	vim.api.nvim_set_hl(0, "String", { fg = nord.green })
	vim.api.nvim_set_hl(0, "Type", { fg = nord.yellow })
	vim.api.nvim_set_hl(0, "Number", { fg = nord.orange })
	vim.api.nvim_set_hl(0, "Boolean", { fg = nord.orange })
	vim.api.nvim_set_hl(0, "Operator", { fg = nord.blue })
	vim.api.nvim_set_hl(0, "Comment", { fg = nord.comment, italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "PreProc", { fg = nord.yellow })
	vim.api.nvim_set_hl(0, "Error", { fg = nord.bg, bg = nord.red, bold = true })
	vim.api.nvim_set_hl(0, "Property", { fg = nord.white })
	vim.api.nvim_set_hl(0, "Atributes", { fg = nord.white })
	vim.api.nvim_set_hl(0, "Tag", { fg = nord.magenta })
	vim.api.nvim_set_hl(0, "Identifier", { fg = nord.blue })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = nord.gray })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = nord.gray })
	vim.api.nvim_set_hl(0, "Special", { fg = nord.cyan })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = nord.gray })
	vim.api.nvim_set_hl(0, "Ibl", { fg = nord.gray })
	vim.api.nvim_set_hl(0, "IblScope", { fg = nord.cyan, bold = true })
end

return theme
