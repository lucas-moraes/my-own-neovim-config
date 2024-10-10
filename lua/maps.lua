local wk = require("which-key")

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local function close_current_buffer()
	local current_buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_delete(current_buf, { force = true })
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
		{ "<leader>fh", telescope.help_tags, desc = "Telescope Help Tags" },
		{ "<leader>fo", telescope.lsp_document_diagnostics, desc = "Telescope LSP Document Diagnostics" },
		{ "<leader>ft", telescope.lsp_workspace_diagnostics, desc = "Telescope LSP Workspace Diagnostics" },
		{ "<leader>fm", telescope.lsp_implementations, desc = "Telescope LSP Implementations" },
		{ "<leader>fq", telescope.quickfix, desc = "Telescope Quickfix" },
		{ "<leader>fl", telescope.loclist, desc = "Telescope Loclist" },
		{ "<leader>fp", telescope.project, desc = "Telescope Project" },
		{ "<leader>fw", telescope.file_browser, desc = "Telescope File Browser" },
		{ "<leader>ft", telescope.filetypes, desc = "Telescope Filetypes" },
		{ "<leader>fk", telescope.keymaps, desc = "Telescope Keymaps" },
		{ "<leader>fo", telescope.oldfiles, desc = "Telescope Oldfiles" },
		{ "<leader>fh", telescope.help_tags, desc = "Telescope Help Tags" },
		{ "<leader>fs", telescope.search_history, desc = "Telescope Search History" },
		{ "<leader>fc", telescope.commands, desc = "Telescope Commands" },
		{ "<leader>fr", "<cmd>lua search_and_replace()<CR>", desc = "Telescope find and replace" },
	})
else
	print("Telescope not found")
end


-- gitsigns
local status, gitsigns = pcall(require, "gitsigns")
if status then

  function _G.git_signs_blame()
    gitsigns.blame_line{full=true}
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
  { "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", desc = "DAP Continue" },
  { "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", desc = "DAP Toggle Breakpoint" },
  { "<leader>dn", "<CMD>lua require'dap'.step_over()<CR>", desc = "DAP Step Over" },
  { "<leader>di", "<CMD>lua require'dap'.step_into()<CR>", desc = "DAP Step Into" },
  { "<leader>do", "<CMD>lua require'dap'.step_out()<CR>", desc = "DAP Step Out" },
  { "<leader>dd", "<CMD>lua require'dap'.disconnect()<CR>", desc = "DAP Disconnect" },
  { "<leader>dr", "<CMD>lua require'dap'.repl.toggle()<CR>", desc = "DAP REPL Toggle" },
  { "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>", desc = "DAP Run Last" },
  { "<leader>du", "<CMD>lua require'dapui'.toggle()<CR>", desc = "DAP UI Toggle" },
  { "<leader>dbd", "<CMD>lua require'dap'.clear_breakpoints()<CR>", desc = "DAP Clear Breakpoints" },
  { "<leader>de", "<CMD>lua require'dapui'.eval()<CR>", desc = "DAP Evaluate" },
  { "<leader>dv", "<CMD>lua require'nvim-dap-virtual-text'.toggle()<CR>", desc = "DAP Virtual Text Toggle" }
})

-- Atalho para fechar buffer
wk.add({
	{ "<leader>cc", ":lua close_current_buffer()<CR>", desc = "Close current buffer" },
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
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- Configuração do vim-multiple
vim.g.VM_maps = {
	["Find Under"] = "<C-d>",
	["Find Subword Under"] = "<C-d>",
}

-- Configuração do vim-multiple-cursors
vim.g.multi_cursor_use_default_mapping = 0
map("n", "<C-d>", "<Plug>(multiple-cursors-find)", {})

-- Mover linha para baixo no modo normal
vim.api.nvim_set_keymap("v", "<C-k-k>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k-k>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Mover linha para cima no modo normal
vim.api.nvim_set_keymap("n", "<C-i-i>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-i-i>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--toggle fold
map("n", "<A-t>", "za", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Down para copiar a linha abaixo
map("n", "<C-A-k>", "yyp", { noremap = true, silent = true })
map("v", "<C-A-k>", "y`>pgv", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Up para copiar a linha acima
map("n", "<C-A-i>", "yyP", { noremap = true, silent = true })
map("v", "<C-A-i>", "y`<Pgv", { noremap = true, silent = true })
