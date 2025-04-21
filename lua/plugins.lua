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


  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("williamboman/mason.nvim")
  use("nvim-neotest/nvim-nio") 
  use("theHamsta/nvim-dap-virtual-text")
  use("jay-babu/mason-nvim-dap.nvim")

  require("configs.dap")

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
          jump = {"<cr>", "<tab>"},
        },
        auto_open = false,
        auto_close = true,
        signs = {
          error = " ",
          warning = " ",
          hint = " ",
          information = " "
        },
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
			require("configs.treesitter")
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
	use({"nvim-tree/nvim-web-devicons"})


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
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
            require 'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                        buftype = { 'terminal', "quickfix" },
                    },
                },
            })
        end,
      }
		},
		config = function()
      vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})
			
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


--------Theme Adjust------------------------------------------------------------------------------------------
  -- Tabs
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


   --[[ config = function() 
      require("configs.lualine.dark-orange")
    end,
    ]]

    --[[config = function() 
      require("configs.lualine.dark-purple")
    end,
    ]]


		requires = { "nvim-web-devicons" },
	})

  -- UI theme
		require("themes.dark-transparent").setup()
		-- require("themes.dark-orange").setup()
		-- require("themes.dark-purple").setup()
		-- require("themes.light").setup()


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
