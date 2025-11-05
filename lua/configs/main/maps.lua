local wk = require("which-key")

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Remapear teclas de navegação

-- left
map("n", "j", "h", { noremap = true, silent = true })
-- down
map("n", "k", "j", { noremap = true, silent = true })
-- right
map("n", "l", "l", { noremap = true, silent = true })
-- up
map("n", "i", "k", { noremap = true, silent = true })
-- edit
map("n", "e", "i", { noremap = true, silent = true })

-- Telescope
local status, telescope = pcall(require, "telescope.builtin")
if status then
	wk.add({
		{ "<leader>f", group = "Telescope" },
		{ "<leader>ff", telescope.find_files, desc = "Telescope Find Files" },
		{ "<leader>fg", telescope.live_grep, desc = "Telescope Live Grep" },
		{ "<leader>fb", telescope.current_buffer_fuzzy_find, desc = "Telescope current buffer" },
		{ "<leader>fr", "<cmd>lua search_and_replace()<CR>", desc = "Telescope find and replace" }, --revisar
	})
else
	print("Telescope not found")
end

-- Theme select
wk.add({
	{ "<leader>t", group = "Theme select" },
	{ "<leader>ts", "<cmd>ThemeSelect<CR>", desc = "Select theme" },
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

-- gitsigns
local status, gitsigns = pcall(require, "gitsigns")
if status then
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

-- Save
wk.add({
	{ "<leader>w", "<CMD>update<CR>", desc = "Save this file" },
	{ "<leader>wa", ":wa<CR>", desc = "Save all files" },
	{ "<leader>wqa", ":wqa!<CR>", desc = "Save and quit all" },
})

-- Quit
wk.add({
	{ "<leader>q", "<CMD>q<CR>", desc = "Quit" },
	{ "<leader>qa", "<CMD>qa!<CR>", desc = "Quit all" },
})

-- Windows
wk.add({
	{ "<leader>|", "<CMD>vsplit<CR>", desc = "Window vertical split" },
	{ "<leader>-", "<CMD>split<CR>", desc = "window horizontal split" },
})

-- NeoTree
wk.add({
	{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Toggle Neotree" },
})

-- Terminal
wk.add({
	{ "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", desc = "Terminal Toggle horizontal" },
	{ "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>", desc = "Terminal Toggle vertical" },
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

-- Atalho lazygit
map("n", "<leader>lg", ":LazyGit<CR>", { noremap = true, silent = true })

-- Atalho lazydocker
-- map("n", "<leader>ld", ":LazyDocker<CR>", { noremap = true, silent = true })

-- Atalho para salvar e sair de tudo
wk.add({
	{ "<leader>qa", "<CMD>qa!<CR>", desc = "Save and quit all" },
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

-- Atalho para fechar buffer
wk.add({
	{ "<leader>cc", ":lua close_current_buffer()<CR>", desc = "Close current buffer" },
	{ "<leader>ca", ":lua close_all_buffers()<CR>", desc = "Close all buffers" },
})

-- Atalho para formatar o código
wk.add({
	{ "<leader>cf", ":Format<CR>", desc = "Format code" },
})

-- Buffer
map("n", "<BS>", "<CMD>bnext<CR>")
map("n", "<TAB>", "<CMD>bprevious<CR>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<leader>L", "<C-w><")
map("n", "<leader>H", "<C-w>>")
map("n", "<leader>J", "<C-w>+")
map("n", "<leader>K", "<C-w>-")

-- Configuração do vim-multiple
vim.g.VM_maps = {
	["Find Under"] = "<C-d>",
	["Find Subword Under"] = "<C-d>",
}

-- Configuração do vim-multiple-cursors
vim.g.multi_cursor_use_default_mapping = 0
map("n", "<C-D>", "<Plug>(multiple-cursors-find)", {})

-- Mover linha para baixo no modo normal
map("n", "<A-K>", ":m .+1<CR>==", { noremap = true, silent = true })
map("n", "<A-J>", ":m .-2<CR>==", { noremap = true, silent = true })
map("v", "<A-K>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "<A-J>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Down para copiar a linha abaixo
map("n", "<C-A-k>", "yyp", { noremap = true, silent = true })
map("v", "<C-A-k>", "y`>pgv", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Up para copiar a linha acima
map("n", "<C-A-i>", "yyP", { noremap = true, silent = true })
map("v", "<C-A-i>", "y`<Pgv", { noremap = true, silent = true })

wk.add({ "<leader>se", vim.diagnostic.open_float, desc = "Mostrar diagnóstico flutuante" })

wk.add({ "<leader>p", vim.lsp.buf.definition, desc = "Mostrar documentação flutuante" })
