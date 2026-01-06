---@diagnostic disable: undefined-global

-- Setup lazy.nvim
require("lazy").setup({

	"nvim-lua/plenary.nvim",

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("configs.plugins_config.dap")
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("configs.plugins_config.copilot")
		end,
	},

	{
		"olimorris/opencode.nvim",
		cmd = "OpenCode",
		config = function()
			require("configs.plugins_config.opencode")
		end,
	},

	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({})
		end,
	},

	{
		"folke/trouble.nvim",
		version = "v2.10.0",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom",
				height = 10,
				icons = true,
				mode = "document_diagnostics",
				fold_open = "",
				fold_closed = "",
				action_keys = {
					close = "q",
					cancel = "<esc>",
					refresh = "r",
					jump = { "<cr>", "<tab>" },
				},
				auto_open = false,
				auto_close = true,
				signs = {
					error = " ",
					warning = " ",
					hint = " ",
					information = " ",
				},
			})
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
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
	},

	{
		"sphamba/smear-cursor.nvim",
		config = function()
			require("smear_cursor").setup({
				legacy_computing_symbols_support = true,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("configs.plugins_config.treesitter")
		end,
	},

	{
		"saghen/blink.indent",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	{
		"pantharshit00/vim-prisma",
	},

	{ "nvim-tree/nvim-web-devicons" },

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"mhartington/formatter.nvim",
		config = function()
			require("configs.plugins_config.formatter")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{ "onsails/lspkind-nvim" },

	{
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
	},

	{ "weilbith/nvim-code-action-menu" },

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "v2.*",
		config = function()
			require("configs.plugins_config.luasnip")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("configs.plugins_config.cmp")
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "cssls", "html", "lua_ls", "tailwindcss" },
			})
		end,
	},

	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
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
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("configs.plugins_config.neo-tree")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("configs.plugins_config.toggleterm")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.plugins_config.gitsigns")
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("which-key")
		end,
	},

	{ "echasnovski/mini.nvim", version = false },

	{
		"mgierada/lazydocker.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"neovim/nvim-lspconfig",
	},



	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-web-devicons" },
	},

	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				groups = {
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
				extra_groups = {},
				exclude_groups = {},
			})
		end,
	},
}, {
	-- Lazy.nvim configuration options
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("configs.plugins_config.theme-manager")
