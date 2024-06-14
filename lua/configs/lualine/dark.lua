local status, lualine = pcall(require, "lualine")
if not status then
	return
end

function _G.close_current_buffer()
	local current_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	-- Se o buffer alternativo não estiver disponível ou for o mesmo que o atual, crie um novo buffer
	if alt_buf == -1 or alt_buf == current_buf then
		vim.cmd("enew")
	else
		vim.cmd("buffer " .. alt_buf)
	end
	vim.api.nvim_buf_delete(current_buf, { force = true })
	require("lualine").refresh()
end

vim.cmd([[
  highlight LualineBufferActive guifg=#ffffff guibg=#5f00af
  highlight LualineBufferInactive guifg=#999999 guibg=#3a3a3a
  highlight WinbarLeftIndent guifg=#3a3a3a guibg=NONE
  highlight WinbarNormal guifg=#999999 guibg=NONE
]])

local function buffer_list()
	local buffers = vim.api.nvim_list_bufs()
	local buffer_names = {}
	local current_buf = vim.api.nvim_get_current_buf()
	local unsaved_icon = "  󰆓 " -- Ícone de exclamação do Nerd Fonts

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			if buf_name ~= "" and not buf_name:match("neo%-tree filesystem") and not buf_name:match("toggleterm") then
				if vim.bo[buf].modified then
					buf_name = buf_name .. unsaved_icon
				end
				buf_name = " " .. buf_name .. " " -- Adiciona espaços ao redor do nome do buffer
				if buf == current_buf then
					table.insert(buffer_names, "%#LualineBufferActive#" .. buf_name) -- "%*" é o reset do estilo
				else
					table.insert(buffer_names, "%#LualineBufferInactive#" .. buf_name)
				end
			end
		end
	end

	if #buffer_names == 0 then
		return "%#LualineBufferInactive# No buffers "
	end

	return table.concat(buffer_names, "%*" .. " " .. "%*")
end

local function left_separator()
	local separator = "   "
	return separator
end

local function right_separator()
	local separator = "   "
	return separator
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = {
				a = { fg = "#f8f8f2", bg = "#5e497c", gui = "bold" },
				b = { fg = "#f8f8f2", bg = "#3b4048" },
				c = { fg = "#f8f8f2", bg = "#282a36" },
			},
			insert = {
				a = { fg = "#f8f8f2", bg = "#206431", gui = "bold" },
				b = { fg = "#f8f8f2", bg = "#3b4048" },
				c = { fg = "#f8f8f2", bg = "#282a36" },
			},
			visual = {
				a = { fg = "#f8f8f2", bg = "#7f5c36", gui = "bold" },
				b = { fg = "#f8f8f2", bg = "#3b4048" },
				c = { fg = "#f8f8f2", bg = "#282a36" },
			},
			replace = {
				a = { fg = "#f8f8f2", bg = "#7f2a2a", gui = "bold" },
				b = { fg = "#f8f8f2", bg = "#3b4048" },
				c = { fg = "#f8f8f2", bg = "#282a36" },
			},
			command = {
				a = { fg = "#f8f8f2", bg = "#375d65", gui = "bold" },
				b = { fg = "#f8f8f2", bg = "#3b4048" },
				c = { fg = "#f8f8f2", bg = "#282a36" },
			},
			inactive = {
				a = { fg = "#6272a4", bg = "#282a36", gui = "bold" },
				b = { fg = "#6272a4", bg = "#282a36" },
				c = { fg = "#6272a4", bg = "#282a36" },
			},
		},
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "neo-tree", "neo-tree filesystem [1]", "toggleterm" },
			winbar = { "neo-tree", "packer", "neo-tree filesystem [1]", "toggleterm" },
		},
		ignore_focus = { "neo-tree", "packer", "neo-tree filesystem [1]", "toggleterm" },
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {
		lualine_a = { left_separator },
		lualine_b = { buffer_list },
		lualine_c = { right_separator },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
