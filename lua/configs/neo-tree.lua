local status, nt = pcall(require, "neo-tree")
if not status then
	return
end

nt.setup({
	close_if_last_window = true,
	filesystem = {
		filtered_items = {
			visible = true, -- Mostra todos os itens, mesmo os filtrados
			hide_dotfiles = false, -- Não oculte arquivos e diretórios ocultos (que começam com .)
			hide_gitignored = false, -- Não oculte arquivos ignorados pelo Git
			hide_by_name = {}, -- Não oculte nenhum arquivo ou diretório pelo nome
			hide_by_pattern = {}, -- Não oculte nenhum arquivo ou diretório por padrão (wildcards)
			always_show = { -- Lista de arquivos ou diretórios que você sempre deseja mostrar
				".gitignore",
			},
		},
	},
	open_on_setup = false, -- Evita abrir automaticamente
	open_on_tab = false, -- Evita abrir automaticamente em novas abas
})
