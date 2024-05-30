local status, bb = pcall(require, "barbar")
if not status then
	return
end

bb.setup({
	options = {
		animation = true,
		auto_hide = false,
		tabpages = true,
		closable = true,
		clickable = true,
		icons = "both", -- Pode ser 'none', 'buffer_number', 'both'
		icon_custom_colors = false,
		icon_close_tab = "",
		icon_close_tab_modified = "●",
		icon_pinned = "車",
		maximum_padding = 1,
		maximum_length = 30,
		semantic_letters = true,
		no_name_title = nil,
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
		},
	},
})
