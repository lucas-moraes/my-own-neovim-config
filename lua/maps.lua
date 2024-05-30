local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local status, telescope = pcall(require, "telescope.builtin")
if status then
	-- Telescope
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

-- Exit insert mode
map("i", "jk", "<ESC>")

-- Windows
map("n", "<leader>|", "<CMD>vsplit<CR>")
map("n", "<leader>-", "<CMD>split<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>o", "<CMD>Neotree focus<CR>")

-- Buffer
map("n", "<TAB>", "<CMD>bnext<CR>")
map("n", "<BS>", "<CMD>bprevious<CR>")

-- Terminal
map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")

-- Markdown Preview
map("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
map("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")

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

-- Atalhos de teclado para navegar entre buffers
map("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- Atalhos de teclado para mover buffers
map("n", "<A-l>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true })
map("n", "<A-h>", ":BufferLineMovePrev<CR>", { noremap = true, silent = true })

-- Atalho de teclado para fechar buffer
map("n", "<leader>c", ":bdelete<CR>", { noremap = true, silent = true })

-- Atalho de teclado para PackerSync
map("n", "<leader>ps", ":PackerSync<CR>", { noremap = true, silent = true })

-- Atalho de teclado para PackerSync
map("n", "<leader>ps", ":PackerSync<CR>", { noremap = true, silent = true })

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

-- Atalhos de teclado para navegar entre buffers
map("n", "<S-l>", ":BufferNext<CR>", { noremap = true, silent = true })
map("n", "<S-h>", ":BufferPrevious<CR>", { noremap = true, silent = true })

-- Atalhos de teclado para mover buffers
map("n", "<A-l>", ":BufferMoveNext<CR>", { noremap = true, silent = true })
map("n", "<A-h>", ":BufferMovePrevious<CR>", { noremap = true, silent = true })

-- Atalho de teclado para fechar buffer
map("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })
