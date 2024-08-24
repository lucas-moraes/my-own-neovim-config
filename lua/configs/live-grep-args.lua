local live_grep_args = require("telescope").extensions.live_grep_args
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function search_and_replace()
	local opts = {
		prompt_title = "Search and Replace",
		shorten_path = false,
		word_match = "-w",
		only_sort_text = true,
		use_regex = true,
	}

	live_grep_args.live_grep_args(opts)

	-- Substituir após selecionar um item
	actions.select_default:replace(function(prompt_bufnr)
		local content = action_state.get_current_picker(prompt_bufnr):get_selection()
		actions.close(prompt_bufnr)

		-- Obter o texto de busca
		local search_text = vim.fn.input("Enter the search text: ")
		if search_text == "" then
			print("No search text provided")
			return
		end

		-- Obter o texto de substituição
		local replace_text = vim.fn.input("Enter the replacement text: ")

		-- Executar substituição no buffer atual
		vim.cmd("%s/" .. search_text .. "/" .. replace_text .. "/gc")
	end)
end

-- Mapear a função para uma combinação de teclas
vim.api.nvim_set_keymap("n", "<leader>sr", "<cmd>lua search_and_replace()<CR>", { noremap = true, silent = true })
