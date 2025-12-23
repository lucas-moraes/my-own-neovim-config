---@diagnostic disable: undefined-global
local wk = require("which-key")

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- edit
map("n", "e", "i")

-- Buffer
map("n", "<BS>", "<CMD>bnext<CR>")
map("n", "<TAB>", "<CMD>bprevious<CR>")

-- Mover linha para baixo no modo normal
map("n", "<A-K>", ":m .+1<CR>==")
map("n", "<A-J>", ":m .-2<CR>==")
map("v", "<A-K>", ":m '>+1<CR>gv=gv")
map("v", "<A-J>", ":m '<-2<CR>gv=gv")

-- Adicionar mapeamento de teclado para Ctrl+Alt+Down para copiar a linha abaixo
map("n", "<C-A-k>", "yyp")
map("v", "<C-A-k>", "y`>pgv")

-- Adicionar mapeamento de teclado para Ctrl+Alt+Up para copiar a linha acima
map("n", "<C-A-i>", "yyP")
map("v", "<C-A-i>", "y`<Pgv")

-- Adicionar indentações no modo visual e permanecer no modo visual
map("v", "<F3>", ">gv")

-- Remover indentações no modo visual e permanecer no modo visual
map("v", "<F4>", "<gv")

-- Atalho para fechar buffer
wk.add({
	{ "<leader>cc", ":lua close_current_buffer()<CR>", desc = "Close current buffer" },
	{ "<leader>ca", ":lua close_all_buffers()<CR>", desc = "Close all buffers" },
})

-- Atalho para formatar o código
wk.add({
	{ "<leader>cf", ":Format<CR>", desc = "Format code" },
})

-- Copilot Chat
wk.add({
	mode = { "n", "v" },
	{ "<leader>c", group = "Copilot Chat" },
	{
		"<leader>cc",
		function()
			require("CopilotChat").open()
		end,
		desc = "Toggle Copilot Chat",
	},
	{ "<leader>cq", "<cmd>CopilotChatQuestion<CR>", desc = "Ask Copilot Chat a question" },
	{ "<leader>ce", ":CopilotChatExplain<CR>", desc = "Explain selection with Copilot Chat" },
	{ "<leader>cr", "<cmd>CopilotChatReset<CR>", desc = "Reset Copilot Chat conversation" },
	{
		"<leader>cmq",
		function()
			local input = vim.fn.input("Prompt: ")
			if input ~= "" then
				require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
			end
		end,
		desc = "Quick prompt com buffer inteiro",
	},
})

-- dap
wk.add({
	{ "<leader>d", group = "DAP" },
	{ "<leader>dc", "<CMD>lua require('dap').continue()<CR>", desc = "DAP Continue" },
	{ "<leader>do", "<CMD>lua require('dap').step_over()<CR>", desc = "DAP Step Over" },
	{ "<leader>di", "<CMD>lua require('dap').step_into()<CR>", desc = "DAP Step Into" },
	{ "<leader>dO", "<CMD>lua require('dap').step_out()<CR>", desc = "DAP Step Out" },
	{ "<leader>dr", "<CMD>lua require('dap').disconnect()<CR>", desc = "DAP Disconnect" },
	{ "<leader>dR", "<CMD>lua require('dap').repl.toggle()<CR>", desc = "DAP REPL Toggle" },
	{ "<leader>dl", "<CMD>lua require('dap').run_last()<CR>", desc = "DAP Run Last" },
	{ "<leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", desc = "DAP Toggle Breakpoint" },
	{ "<leader>dC", "<CMD>lua require('dap').clear_breakpoints()<CR>", desc = "DAP Clear Breakpoints" },
	{ "<leader>dv", "<CMD>lua require('nvim-dap-virtual-text').toggle()<CR>", desc = "DAP Virtual Text Toggle" },
	{ "<leader>du", "<CMD>lua require('dapui').toggle()<CR>", desc = "DAP UI Toggle" },
})

-- NeoTree
wk.add({
	{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Toggle Neotree" },
})

-- Telescope
local status, telescope = pcall(require, "telescope.builtin")
if status then
	wk.add({
		{ "<leader>f", group = "Telescope" },
		{ "<leader>ff", telescope.find_files, desc = "Telescope Find Files" },
		{ "<leader>fg", telescope.live_grep, desc = "Telescope Live Grep" },
		{ "<leader>fb", telescope.current_buffer_fuzzy_find, desc = "Telescope current buffer" },
	})
else
	print("Telescope not found")
end

-- gitsigns
local _, gitsigns = pcall(require, "gitsigns")
if _ then
	function _G.git_signs_blame()
		gitsigns.blame_line({ full = true })
	end

	wk.add({
		{ "<leader>gb", git_signs_blame, desc = "git commit blame" },
		{ "<leader>gl", gitsigns.toggle_current_line_blame, desc = "git line blame" },
	})
else
	print("gitsigns not found")
end

wk.add({
	{ "<leader>l", group = "LazyGit/LazyDocker" },
	{ "<leader>lg", ":LazyGit<CR>", desc = "LazyGit" },
	--{"<leader>ld", ":LazyDocker<CR>", desc = "LazyDocker"},
})

-- Markdown Preview
wk.add({
	{ "<leader>m", "<CMD>MarkdownPreview<CR>", desc = "Markdown Preview" },
	{ "<leader>mn", "<CMD>MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop" },
})

-- Atalho de teclado para PackerSync
wk.add({
	{ "<leader>ps", "<CMD>PackerSync<CR>", desc = "PackerSync" },
})

wk.add({ "<leader>p", vim.lsp.buf.definition, desc = "Mostrar documentação flutuante" })

wk.add({ "<leader>se", vim.diagnostic.open_float, desc = "Mostrar diagnóstico flutuante" })

-- Quit
wk.add({
	{ "<leader>q", "<CMD>q<CR>", desc = "Quit" },
	{ "<leader>qa", "<CMD>qa!<CR>", desc = "Quit all" },
})

-- Theme select
wk.add({
	{ "<leader>t", group = "Theme select" },
	{ "<leader>ts", "<cmd>ThemeSelect<CR>", desc = "Select theme" },
})

-- Terminal
wk.add({
	{ "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", desc = "Terminal Toggle horizontal" },
	{ "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>", desc = "Terminal Toggle vertical" },
})

-- Save
wk.add({
	{ "<leader>w", "<CMD>update<CR>", desc = "Save this file" },
	{ "<leader>wa", ":wa<CR>", desc = "Save all files" },
	{ "<leader>wqa", ":wqa!<CR>", desc = "Save and quit all" },
})

--UFO collapse
local status, ufo = pcall(require, "ufo")
if status then
	wk.add({
		{ "<leader>z", group = "UFO Collapse" },
		{ "<leader>zj", ufo.openAllFolds, desc = "Abrir todos os folds" },
		{ "<leader>zc", ufo.closeAllFolds, desc = "Fechar todos os folds" },
	})
else
	print("UFO not found")
end

-- Windows
wk.add({
	{ "<leader>|", "<CMD>vsplit<CR>", desc = "Window vertical split" },
	{ "<leader>-", "<CMD>split<CR>", desc = "window horizontal split" },
})
