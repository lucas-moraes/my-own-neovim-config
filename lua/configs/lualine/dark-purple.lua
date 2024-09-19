local status, lualine = pcall(require, "lualine")
if not status then
	return
end

-- Armazena o ícone do Copilot
local copilot_status_icon = ""

local function update_copilot_icon()
  -- Chama o comando 'Copilot status' de forma assíncrona
  vim.fn.jobstart("Copilot status 2>&1", {
    stdout_buffered = true,
    on_stdout = function(_, data)
      -- Atualiza o ícone com base no resultado do comando
      if data and table.concat(data):find("Copilot: Ready") then
        copilot_status_icon = "" -- Ícone do Copilot
      else
        copilot_status_icon = ""
      end
      -- Atualiza o lualine após receber o resultado
      require("lualine").refresh()
    end,
    on_stderr = function(_, _)
      copilot_status_icon = "" -- Em caso de erro, não mostrar ícone
      require("lualine").refresh()
    end,
  })
end

-- Função que retorna o ícone do Copilot
local function copilot_icon()
  return copilot_status_icon
end

-- Atualiza o ícone do Copilot ao inicializar
update_copilot_icon()

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
  highlight LualineBufferActive guifg=#34004c guibg=#b000ff
  highlight LualineBufferInactive guifg=#a799ad guibg=#34004c
  highlight WinbarLeftIndent guifg=#4e325b guibg=NONE
  highlight WinbarNormal guifg=#b0aba6 guibg=NONE
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
	local separator = "   "
	return separator
end

local function right_separator()
	local separator = "   "
	return separator
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = {
				a = { fg = "#b000ff", bg = "#58007f", gui = "bold" },
				b = { fg = "#b000ff", bg = "#34004c" },
				c = { fg = "#b000ff", bg = "#110019" },
			},
			insert = {
				a = { fg = "#34004c", bg = "#00ff04", gui = "bold" },
				b = { fg = "#b000ff", bg = "#34004c" },
				c = { fg = "#b000ff", bg = "#110019" },
			},
			visual = {
				a = { fg = "#34004c", bg = "#fdff00", gui = "bold" },
				b = { fg = "#b000ff", bg = "#34004c" },
				c = { fg = "#b000ff", bg = "#110019" },
			},
			replace = {
				a = { fg = "#b000ff", bg = "#ff00c1", gui = "bold" },
				b = { fg = "#b000ff", bg = "#34004c" },
				c = { fg = "#b000ff", bg = "#110019" },
			},
			command = {
				a = { fg = "#34004c", bg = "#00dfff", gui = "bold" },
				b = { fg = "#b000ff", bg = "#34004c" },
				c = { fg = "#b000ff", bg = "#110019" },
			},
			inactive = {
				a = { fg = "#b000ff", bg = "#110019", gui = "bold" },
				b = { fg = "#b000ff", bg = "#110019" },
				c = { fg = "#b000ff", bg = "#110019" },
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
		lualine_x = { copilot_icon, "filetype" },
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
