local M = {}

function M.setup()
  vim.o.termguicolors = true

  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"

  local colors = {
    bg       = "#001643",
    fg       = "#FFFFFF",
    comment  = "#002f90",
    green    = "#90e500",
    yellow   = "#FFED00",
    blue     = "#4482ff",
    white    = "#FFFFFF",
    error    = "#FF5555",
  }

  -- Fundo
  vim.api.nvim_set_hl(0, "Normal", { bg = colors.bg, fg = colors.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.bg })

  -- Texto invisível
  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<"
  vim.api.nvim_set_hl(0, "Whitespace", { fg = colors.comment })
  vim.api.nvim_set_hl(0, "NonText", { fg = colors.comment })

  -- Interface
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#00133c" })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#00133c" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#00133c" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.comment })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.white, bg = colors.blue })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.comment, bg = colors.bg })
  vim.api.nvim_set_hl(0, "TabLine", { fg = colors.white, bg = colors.bg })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.bg, bg = colors.green })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.comment })

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
  vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#44475a" })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = colors.comment })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#a093d8" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = "#6866da", bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#00133c" })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#6866da", bg = "none" })

  -- Código
  vim.api.nvim_set_hl(0, "Keyword", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Function", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Parameter", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "String", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "Type", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Number", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Boolean", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Operator", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, "Constant", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Error", { fg = colors.bg, bg = colors.error, bold = true })
  vim.api.nvim_set_hl(0, "Property", { fg = colors.white })
  vim.api.nvim_set_hl(0, "Tag", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.comment })
  vim.api.nvim_set_hl(0, "PunctuationBracket", { fg = colors.comment })
  vim.api.nvim_set_hl(0, "Special", { fg = colors.blue })
end

return M

