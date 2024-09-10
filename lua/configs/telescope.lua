local status, telescope = pcall(require, "telescope")
local lga_actions = require("telescope._extensions.live_grep_args.actions")

if not status then
	return
end

telescope.setup({
	defaults = {
    cwb = vim.fn.getcwd(),
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "│", "─", "╭", "╮", "╯", "╰", "│", "─" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- Habilita a adição automática de aspas aos argumentos do rg
			mappings = { -- Extensão de mapeamento para as ações da extensão
				i = {
					["<C-k>"] = lga_actions.quote_prompt(), -- Adiciona citações em torno da string de busca
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- Adiciona citações em torno da string de busca e usa glob para incluir arquivos
				},
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("live_grep_args")
