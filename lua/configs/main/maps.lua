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

-- Copy utilities
local utils_status, utils = pcall(require, "utils")
if utils_status then
	wk.add({
		{ "<C-c>", utils.copy_absolute_path, desc = "Copy absolute path" },
	})
end

wk.add({
	{ "<leader>cf", ":Format<CR>", desc = "Format code" },
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
		{ "<leader>fb", "<cmd>Telescope live_grep search_dirs=%:p<CR>", desc = "Telescope current buffer" },
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
	{ "<leader>l", group = "Lazy tools" },
	{ "<leader>ll", ":Lazy<CR>", desc = "Lazy" },
	{ "<leader>ls", ":Lazy sync<CR>", desc = "Lazy Sync" },
	{ "<leader>lc", ":Lazy clean<CR>", desc = "Lazy Clean" },
	{ "<leader>lu", ":Lazy update<CR>", desc = "Lazy Update" },
	{ "<leader>lg", ":LazyGit<CR>", desc = "LazyGit" },
	--{"<leader>ld", ":LazyDocker<CR>", desc = "LazyDocker"},
})

-- Markdown Preview
wk.add({
	{ "<leader>m", "<CMD>MarkdownPreview<CR>", desc = "Markdown Preview" },
	{ "<leader>mn", "<CMD>MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop" },
})

-- OpenCode
wk.add({
	{ "<leader>o", group = "OpenCode" },
	{
		"<leader>oa",
		function()
			require("opencode").ask("@this: ", { submit = true })
		end,
		desc = "Ask OpenCode",
	},
	{
		"<leader>ox",
		function()
			require("opencode").select()
		end,
		desc = "Execute OpenCode action",
	},
	{
		"<leader>ot",
		function()
			require("opencode").toggle()
		end,
		desc = "Toggle OpenCode",
	},
	{
		"<leader>op",
		function()
			return require("opencode").operator("@this ")
		end,
		mode = "x",
		expr = true,
		desc = "Add range to opencode",
	},
	{
		"<leader>ol",
		function()
			return require("opencode").operator("@this ") .. "_"
		end,
		mode = "n",
		expr = true,
		desc = "Add line to opencode",
	},
	{
		"<leader>ou",
		function()
			require("opencode").command("session.half.page.up")
		end,
		desc = "Opencode half page up",
	},
	{
		"<leader>od",
		function()
			require("opencode").command("session.half.page.down")
		end,
		desc = "Opencode half page down",
	},
})

wk.add({
	"<leader>p",
	function()
		vim.lsp.buf.definition({
			on_list = function(options)
				local items = vim.tbl_filter(function(item)
					return not item.filename:match("node_modules")
				end, options.items)

				if vim.tbl_isempty(items) then
					vim.notify("Nenhuma definição fora de node_modules", vim.log.levels.INFO)
					return
				end

				vim.ui.select(items, {
					prompt = "Definições",
					format_item = function(item)
						return string.format("%s:%d:%d", vim.fn.fnamemodify(item.filename, ":~:."), item.lnum, item.col)
					end,
				}, function(choice)
					if choice then
						vim.cmd("edit " .. choice.filename)
						vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
					end
				end)
			end,
		})
	end,
	desc = "Mostrar documentação flutuante",
})

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

-- Atalho para fechar buffer
wk.add({
	{ "<leader>xx", ":lua close_current_buffer()<CR>", desc = "Close current buffer" },
	{ "<leader>xa", ":lua close_all_buffers()<CR>", desc = "Close all buffers" },
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
