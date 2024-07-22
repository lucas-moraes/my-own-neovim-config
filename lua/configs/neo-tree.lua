local status, nt = pcall(require, "neo-tree")
if not status then
	return
end

nt.setup({
	close_if_last_window = true,
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
	open_on_setup = false, -- Adicione esta linha para evitar abrir automaticamente
	open_on_tab = false, -- Adicione esta linha para evitar abrir automaticamente em novas abas
})
