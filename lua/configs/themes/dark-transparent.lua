---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
	vim.o.termguicolors = true
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	local dracula = {
		bg = "#282a36",
		fg = "#f8f8f2",
		comment = "#6272a4",
		red = "#ff5555",
		orange = "#ffb86c",
		yellow = "#f1fa8c",
		green = "#50fa7b",
		cyan = "#8be9fd",
		blue = "#6272a4",
		magenta = "#bd93f9",
		pink = "#ff79c6",
		black = "#21222c",
		white = "#f8f8f2",
		gray = "#44475a",
	}

	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", fg = "NONE" })
	vim.opt.fillchars:append({ eob = " " })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE", bg = "NONE" })

	vim.o.list = false
	vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
	vim.api.nvim_set_hl(0, "Whitespace", { fg = dracula.gray })
	vim.api.nvim_set_hl(0, "NonText", { fg = dracula.gray })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = dracula.gray })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = dracula.black })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = dracula.black })
	vim.api.nvim_set_hl(0, "LineNr", { fg = dracula.comment })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dracula.yellow })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = dracula.white, bg = dracula.gray })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = dracula.comment, bg = dracula.black })
	vim.api.nvim_set_hl(0, "TabLine", { fg = dracula.white, bg = dracula.black })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = dracula.black })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = dracula.black, bg = dracula.pink })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = dracula.gray })

	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = dracula.magenta, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = dracula.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = dracula.green })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = dracula.orange })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = dracula.red })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = dracula.red })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = dracula.gray })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = dracula.cyan })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = dracula.white, bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = dracula.gray })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = dracula.pink })

	vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = dracula.comment, italic = true })

	vim.api.nvim_set_hl(0, "Keyword", { fg = dracula.pink })
	vim.api.nvim_set_hl(0, "Function", { fg = dracula.green })
	vim.api.nvim_set_hl(0, "Parameter", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "String", { fg = dracula.yellow })
	vim.api.nvim_set_hl(0, "Type", { fg = dracula.cyan })
	vim.api.nvim_set_hl(0, "Number", { fg = dracula.orange })
	vim.api.nvim_set_hl(0, "Boolean", { fg = dracula.orange })
	vim.api.nvim_set_hl(0, "Operator", { fg = dracula.magenta })
	vim.api.nvim_set_hl(0, "Comment", { fg = dracula.comment, italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = dracula.cyan })
	vim.api.nvim_set_hl(0, "PreProc", { fg = dracula.pink })
	vim.api.nvim_set_hl(0, "Error", { fg = dracula.bg, bg = dracula.red, bold = true })
	vim.api.nvim_set_hl(0, "Property", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "Atributes", { fg = dracula.white })
	vim.api.nvim_set_hl(0, "Tag", { fg = dracula.magenta })
	vim.api.nvim_set_hl(0, "Identifier", { fg = dracula.magenta })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = dracula.comment })
	vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = dracula.comment })
	vim.api.nvim_set_hl(0, "Special", { fg = dracula.cyan })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = dracula.gray })
	vim.api.nvim_set_hl(0, "Ibl", { fg = dracula.gray })
	vim.api.nvim_set_hl(0, "IblScope", { fg = dracula.cyan, bold = true })
end

return theme
