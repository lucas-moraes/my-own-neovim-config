local status, nt = pcall(require, "neo-tree")
if not status then
	return
end

nt.setup({
	close_if_last_window = true,
  window = {
    width = 50,
  },
	filesystem = {
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
	},
	default_component_configs = {
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

