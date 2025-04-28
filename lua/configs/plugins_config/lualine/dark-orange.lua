local status, lualine = pcall(require, "lualine")
if not status then
	return
end

function _G.close_current_buffer()
	local current_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	if alt_buf == -1 or alt_buf == current_buf then
		vim.cmd("enew")
	else
		vim.cmd("buffer " .. alt_buf)
	end
	vim.api.nvim_buf_delete(current_buf, { force = true })
	lualine.refresh()
end

vim.cmd([[
  highlight LualineBufferActive guifg=#3a2d22 guibg=#ffaf40
  highlight LualineBufferInactive guifg=#b0aba6 guibg=#3a2d22
  highlight WinbarLeftIndent guifg=#61564e guibg=NONE
  highlight WinbarNormal guifg=#b0aba6 guibg=NONE
]])

local function buffer_list()
	local buffers = vim.api.nvim_list_bufs()
	local buffer_names = {}
	local current_buf = vim.api.nvim_get_current_buf()
	local unsaved_icon = "  ◉" -- Ícone de exclamação do Nerd Fonts

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			if buf_name ~= "" and not buf_name:match("neo%-tree filesystem") and not buf_name:match("toggleterm") then
				if vim.bo[buf].modified then
					buf_name = buf_name .. unsaved_icon
				end
				buf_name = " " .. buf_name .. " "
				if buf == current_buf then
					table.insert(buffer_names, "%#LualineBufferActive#" .. buf_name)
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
	local separator = " ▶ "
	return separator
end

local function right_separator()
	local separator = " ◀ "
	return separator
end

local function relative_file_path()
  local file_path = vim.fn.expand("%:~:.")
  return file_path
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = {
				a = { fg = "#ffb44c", bg = "#995900", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#663b00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
			insert = {
				a = { fg = "#104c00", bg = "#00ff95", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#663b00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
			visual = {
				a = { fg = "#4c4100", bg = "#9500ff", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#663b00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
			replace = {
				a = { fg = "#ffb44c", bg = "#7f2a2a", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#663b00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
			command = {
				a = { fg = "#663b00", bg = "#95daff", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#663b00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
			inactive = {
				a = { fg = "#ffb44c", bg = "#190e00", gui = "bold" },
				b = { fg = "#ffb44c", bg = "#190e00" },
				c = { fg = "#ffb44c", bg = "#190e00" },
			},
		},
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { 
        "neo-tree", 
        "neo-tree filesystem [1]", 
        "toggleterm",
      },
			winbar = { 
        "neo-tree", 
        "packer", 
        "neo-tree filesystem [1]", 
        "toggleterm",
      },
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
		lualine_c = { relative_file_path },
		lualine_x = {},
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
