local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run: PackerCompile
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

return require("packer").startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")

	-- Common utilities
	use("nvim-lua/plenary.nvim")

	-- Prisma File manager
	use({
		"pantharshit00/vim-prisma",
	})

	-- Icons
	use("nvim-tree/nvim-web-devicons")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"mhartington/formatter.nvim",
		config = function()
			require("configs.formatter")
		end,
	})

	-- rust-tools
	use({
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	})

	-- crates
	use({
		"saecki/crates.nvim",
		config = function()
			require("crates").setup({})
		end,
	})

	-- dap
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("configs.dap")
		end,
	})

	use({
		"neoclide/coc.nvim",
		branch = "release",
	})

	-- multiline select
	use("mg979/vim-visual-multi")
	use("terryma/vim-multiple-cursors")

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",

		--[[ config = function()
			require("configs.lualine.light")
		end,
    ]]

		config = function()
			require("configs.lualine.dark")
		end,

		requires = { "nvim-web-devicons" },
	})

	use({
		"neoclide/coc/nvim",
		branch = "release",
	})

	use({
		"~/.config/nvim/lua/themes",
		config = function()
			require("themes.dark-transparent").setup()
			-- require("themes.dark").setup()
			-- require("themes.light").setup()
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-telescope/telescope-live-grep-args.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("configs.live-grep-args")
		end,
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	})

	use({ "onsails/lspkind-nvim" })

	use({ "windwp/nvim-ts-autotag" })

	use({ "weilbith/nvim-code-action-menu" })

	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*",
		config = function()
			require("configs.luasnip")
		end,
	})

	-- cmp: Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("configs.cmp")
		end,
	})

	use("hrsh7th/cmp-nvim-lsp")

	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- Mason: Portable package manager
	use({
		"williamboman/mason.nvim",
		config = function()
			require("configs.mason")
		end,
	})

	use("williamboman/mason-lspconfig.nvim")

	-- File manager
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("configs.neo-tree")
		end,
	})

	-- Show colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("configs.toggleterm")
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	})

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key")
		end,
	})

	use({ "echasnovski/mini.nvim", version = false })

	use({
		"mgierada/lazydocker.nvim",
		drequires = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({})
		end,
	})

	-- nvim v0.7.2
	use({
		"kdheepak/lazygit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Background Transparent
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				groups = { -- table: default groups
					"Normal",
					"NormalNC",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"ignColumn",
					"CursorLineNr",
					"EndOfBuffer",
				},
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})
		end,
	})
end)
