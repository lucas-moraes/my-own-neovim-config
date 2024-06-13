local theme = {}

theme.base00 = "#1d2021"
theme.base01 = "#3c3836"
theme.base02 = "#504945"
theme.base03 = "#665c54"
theme.base04 = "#bdae93"
theme.base05 = "#d5c4a1"
theme.base06 = "#ebdbb2"
theme.base07 = "#fbf1c7"
theme.base08 = "#fb4934"
theme.base09 = "#fe8019"
theme.base0A = "#fabd2f"
theme.base0B = "#b8bb26"
theme.base0C = "#8ec07c"
theme.base0D = "#83a598"
theme.base0E = "#d3869b"
theme.base0F = "#d65d0e"

function theme.setup()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	vim.o.background = "dark"

	-- Define highlights
	vim.api.nvim_set_hl(0, "Normal", { fg = theme.base05, bg = "#1d2021" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
	-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
	-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "NONE" }) -- Coluna de cores
	-- vim.api.nvim_set_hl(0, "TabLineFill", { fg = theme.base01, bg = theme.base00 }) -- Preenchimento da linha de abas

	-- Custom highlights for NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = theme.base0A, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = theme.base0D })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = theme.base0D })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = theme.base05 })
	vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = theme.base05 })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = theme.base0B })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = theme.base08 })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = theme.base09 })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = theme.base04 })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = theme.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = theme.base05 })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = theme.base05, bg = theme.base00 })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = theme.base00 })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = theme.base01 })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = theme.base06, bg = theme.base02 })
end

return theme
