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

-- leader key

-- Telescope
local status, telescope = pcall(require, "telescope.builtin")
if status then
	map("n", "<leader>ff", telescope.find_files)
	map("n", "<leader>fg", telescope.live_grep)
	map("n", "<leader>fb", telescope.buffers)
	map("n", "<leader>fh", telescope.help_tags)
	map("n", "<leader>fs", telescope.git_status)
	map("n", "<leader>fc", telescope.git_commits)
else
	print("Telescope not found")
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quit
map("n", "<leader>q", "<CMD>q<CR>")

-- Windows
map("n", "<leader>|", "<CMD>vsplit<CR>")
map("n", "<leader>-", "<CMD>split<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")

-- Terminal
map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")

-- Markdown Preview
map("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
map("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")

-- Atalho de teclado para PackerSync
map("n", "<leader>ps", ":PackerSync<CR>", { noremap = true, silent = true })

-- Atalho lazygit
map("n", "<leader>lg", ":LazyGit<CR>", { noremap = true, silent = true })

-- Atalho para sair de tudo
map("n", "<leader>wqa", ":wqa!<CR>", { noremap = true, silent = true })

-- Atalho para salvar e sair de tudo
map("n", "<leader>qa", ":qa!<CR>", { noremap = true, silent = true })

-- Atalho para dar refresh no neovim
map("n", "<leader>r", ":source $MYVIMRC<CR>", { noremap = true, silent = true })

-- Exit insert mode
map("i", "jk", "<ESC>")

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
map("v", "<C-d>", "<Plug>(multiple-cursors-find)", {})
map("i", "<C-d>", "<Plug>(multiple-cursors-find)", {})

-- Mover linha para baixo
map("n", "<A-k>", ":m .+1<CR>==", { noremap = true, silent = true })
map("i", "<A-k>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
map("v", "<A-k>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Mover linha para cima
map("n", "<A-i>", ":m .-2<CR>==", { noremap = true, silent = true })
map("i", "<A-i>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
map("v", "<A-i>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--toggle fold
map("n", "<A-t>", "za", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Down para copiar a linha abaixo
map("n", "<C-A-k>", "yyp", { noremap = true, silent = true })
map("v", "<C-A-k>", "y`>pgv", { noremap = true, silent = true })

-- Adicionar mapeamento de teclado para Ctrl+Alt+Up para copiar a linha acima
map("n", "<C-A-i>", "yyP", { noremap = true, silent = true })
map("v", "<C-A-i>", "y`<Pgv", { noremap = true, silent = true })
