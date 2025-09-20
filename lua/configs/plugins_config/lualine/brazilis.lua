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

function _G.close_all_buffers()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end

	local alt_buf = vim.fn.bufnr("#")
	if alt_buf ~= -1 and vim.api.nvim_buf_is_valid(alt_buf) and alt_buf ~= current_buf then
		vim.cmd("buffer " .. alt_buf)
	end

	if vim.api.nvim_buf_is_loaded(current_buf) then
		vim.api.nvim_buf_delete(current_buf, { force = true })
	end
end

vim.cmd([[
  highlight LualineBufferActive guifg=#002776 guibg=#4482ff
  highlight LualineBufferInactive guifg=#4482ff guibg=#002776
  highlight WinbarLeftIndent guifg=#44475a guibg=NONE
  highlight WinbarNormal guifg=#f8f8f2 guibg=NONE
]])

local function buffer_list()
	local buffers = vim.api.nvim_list_bufs()
	local buffer_names = {}
	local current_buf = vim.api.nvim_get_current_buf()
	local unsaved_icon = "  ◉"

	local ignored_types = {
		["neo-tree"] = true,
		["neo-tree filesystem [1]"] = true,
		["toggleterm"] = true,
		["dap-repl"] = true,
		["dapui_scopes"] = true,
		["dapui_stacks"] = true,
		["dapui_breakpoints"] = true,
		["dapui_watches"] = true,
		["dapui_console"] = true,
		["dapui_hover"] = true,
		["quicknotes"] = true,
	}

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local ft = vim.bo[buf].filetype
			if not ignored_types[ft] then
				local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
				if buf_name ~= "" then
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

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		vim.schedule(function()
			require("lualine").refresh({ winbar = true })
		end)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.schedule(function()
			require("lualine").refresh({ winbar = true })
		end)
	end,
})

lualine.setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = {
				a = { fg = "#ffffff", bg = "#0038a9", gui = "bold" },
				b = { fg = "#FFFFFF", bg = "#002776" },
				c = { fg = "#FFFFFF", bg = "#001643" },
			},
			insert = {
				a = { fg = "#0a0a0a", bg = "#009739", gui = "bold" },
				b = { fg = "#FFFFFF", bg = "#002776" },
				c = { fg = "#FFFFFF", bg = "#001643" },
			},
			visual = {
				a = { fg = "#0a0a0a", bg = "#FFCC29", gui = "bold" },
				b = { fg = "#FFFFFF", bg = "#002776" },
				c = { fg = "#FFFFFF", bg = "#001643" },
			},
			replace = {
				a = { fg = "#0a0a0a", bg = "#FF5555", gui = "bold" },
				b = { fg = "#FFFFFF", bg = "#002776" },
				c = { fg = "#FFFFFF", bg = "#001643" },
			},
			command = {
				a = { fg = "#0a0a0a", bg = "#FFFFFF", gui = "bold" },
				b = { fg = "#FFFFFF", bg = "#002776" },
				c = { fg = "#FFFFFF", bg = "#001643" },
			},
			inactive = {
				a = { fg = "#4a4a4a", bg = "#001643", gui = "bold" },
				b = { fg = "#4a4a4a", bg = "#001643" },
				c = { fg = "#4a4a4a", bg = "#001643" },
			},
		},
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "neo-tree", "neo-tree filesystem [1]", "toggleterm" },
			winbar = { "neo-tree", "packer", "neo-tree filesystem [1]", "toggleterm" },
		},
		ignore_focus = { "neo-tree", "packear", "neo-tree filesystem [1]", "toggleterm" },
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
		lualine_y = {
			{
				function()
					local ok, copilot_enabled = pcall(vim.fn["copilot#Enabled"])
					if ok and copilot_enabled == 1 then
						return " " -- ícone do GitHub (Font Nerds ou NerdFont)
					else
						return ""
					end
				end,
				color = { fg = "#6CC644" }, -- verde, igual Copilot
				cond = function()
					local ok, copilot_enabled = pcall(vim.fn["copilot#Enabled"])
					return ok and copilot_enabled == 1
				end,
			},
		},
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
