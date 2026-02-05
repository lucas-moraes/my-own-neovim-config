local status, nt = pcall(require, "neo-tree")
if not status then
	return
end

-- Function to copy relative path to clipboard
local function copy_relative_path(state)
	local node = state.tree:get_node()
	if not node then
		return
	end
	local path = node:get_id()
	local relative_path = vim.fn.fnamemodify(path, ":.")
	vim.fn.setreg("+", relative_path)
	vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
end

-- Function to paste clipboard content to command line
local function paste_to_command_line(state)
	local clipboard = vim.fn.getreg("+")
	if clipboard and clipboard ~= "" then
		-- Open command line with paste content
		vim.api.nvim_feedkeys(":" .. clipboard, "n", false)
	else
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
	end
end

nt.setup({
	close_if_last_window = true,
	window = {
		width = 50,
	},
	filesystem = {
		renderers = {
			file = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
			},
			directory = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
			},
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {},
			hide_by_patter = {},
			always_show = {
				".gitignore",
			},
		},
		commands = {
			copy_relative_path = copy_relative_path,
			paste_to_command_line = paste_to_command_line,
		},
		window = {
			mappings = {
				["<C-c>"] = "copy_relative_path",
				["<C-v>"] = "paste_to_command_line",
			},
		},
	},
	default_component_configs = {
    size = {enabled = false},
    last_modified = {enabled = false},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			default = "",
			highlight = "NeoTreeFileIcon"
		},
		git_status = {
			symbols = {
				added = "+",
				deleted = "-",
				modified = "",
				renamed = "➜",
				untracked = "",
				ignored = "◌",
				unstaged = "★",
				staged = "★★",
				conflict = "",
			}
		},
		diagnostics = {
			symbols = {
				error = "",
				warn = "",
				info = "",
				hint = "",
			},
		},
	},
	open_on_setup = false, -- Evita abrir automaticamente
	open_on_tab = false, -- Evita abrir automaticamente em novas abas
})

