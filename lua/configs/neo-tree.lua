local status, nt = pcall(require, "neo-tree")
if not status then
	return
end

nt.setup({
	close_if_last_window = true,
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = true,
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				-- Auto close Neo-tree when a file is opened
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
		{
			event = "TreeOpened",
			handler = function()
				require("lualine").setup({
					options = {
						disabled_filetypes = {
							"neo-tree",
							"packer",
							statusline = { "neo-tree", "neo-tree filesystem [1]" },
							winbar = { "packer" },
						},
						ignore_focus = { "neo-tree", "neo-tree filesystem [1]" },
					},
				})
			end,
		},
	},
	open_on_setup = false, -- Adicione esta linha para evitar abrir automaticamente
	open_on_tab = false, -- Adicione esta linha para evitar abrir automaticamente em novas abas
})
