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
	open_on_setup = false, -- Adicione esta linha para evitar abrir automaticamente
	open_on_tab = false, -- Adicione esta linha para evitar abrir automaticamente em novas abas
})
