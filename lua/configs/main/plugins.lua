vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})
--ssada
return require("packer").startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")

	-- Common utilities
	use("nvim-lua/plenary.nvim")

	use({
		"mxsdev/nvim-dap-vscode-js",
		requires = { "mfussenegger/nvim-dap" },
	})

	-- 2️⃣ Depois carrega o DAP com sua configuração
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"mxsdev/nvim-dap-vscode-js",
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("configs.plugins_config.dap")
		end,
	})

	--Copilot
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("configs.plugins_config.copilot")
		end,
	})

	-- ui amigável
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				select = {
					backend = { "telescope" }, -- ou "telescope", se preferir
				},
			})
		end,
	})

	-- Trouble
	use({
		"folke/trouble.nvim",
		tag = "v2.10.0",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom",
				height = 10,
				icons = true,
				mode = "document_diagnostics",
				fold_open = "",
				fold_closed = "",
				action_keys = {
					close = "q",
					cancel = "<esc>",
					refresh = "r",
					jump = { "<cr>", "<tab>" },
				},
				auto_open = false,
				auto_close = true,
				signs = {
					error = " ",
					warning = " ",
					hint = " ",
					information = " ",
				},
			})
		end,
	})

	-- UFO - Collapse blocks
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	})

	use({
		"sphamba/smear-cursor.nvim",
		config = function()
			require("smear_cursor").setup({
				legacy_computing_symbols_support = true,
			})
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("configs.plugins_config.treesitter")
		end,
	})

	-- indent-blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
				},
				scope = {
					enabled = true,
					show_start = true,
					show_end = true,
				},
			})
		end,
	})

	-- Prisma File manager
	use({
		"pantharshit00/vim-prisma",
	})

	-- Icons
	use({ "nvim-tree/nvim-web-devicons" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"mhartington/formatter.nvim",
		config = function()
			require("configs.plugins_config.formatter")
		end,
	})

	-- multiline select
	use("mg979/vim-visual-multi")
	use("terryma/vim-multiple-cursors")

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
			require("configs.plugins_config.live-grep-args")
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
			require("configs.plugins_config.lsp")
		end,
	})

	use({ "onsails/lspkind-nvim" })

	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	})

	use({ "weilbith/nvim-code-action-menu" })

	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
		tag = "v2.*",
		config = function()
			require("configs.plugins_config.luasnip")
		end,
	})

	-- cmp: Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp", -- fonte LSP
			"hrsh7th/cmp-buffer", -- fonte buffer
			"hrsh7th/cmp-path", -- fonte paths
			"saadparwaiz1/cmp_luasnip", -- fonte snippets do LuaSnip
			"L3MON4D3/LuaSnip", -- o próprio LuaSnip
			"rafamadriz/friendly-snippets", -- snippets prontos (opcional)
		},
		config = function()
			require("configs.plugins_config.cmp")
		end,
	})

	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- Mason: Portable package manager
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		after = "mason.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "cssls", "html", "lua_ls", "tailwindcss" },
			})
		end,
	})

	use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })

	-- File manager
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("configs.plugins_config.neo-tree")
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
			require("configs.plugins_config.toggleterm")
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.plugins_config.gitsigns")
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

	--------Theme Adjust------------------------------------------------------------------------------------------
	-- Tabs
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-web-devicons" },
	})

	require("configs.plugins_config.theme-manager")
	--------------------------------------------------------------------------------------------------------------

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
