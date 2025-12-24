---@diagnostic disable: undefined-global

local status, c = pcall(require, "CopilotChat")
if not status then
	return
end

local columns = vim.o.columns
local lines = vim.o.lines

c.setup({
	window = {
		layout = "float",
		relative = "editor",

		winhighlight = table.concat({
			"Normal:CopilotChatNormal",
			"NormalFloat:CopilotChatNormal",
			"FloatBorder:CopilotChatBorder",
		}, ","),

		width = math.floor(columns * 0.38),
		height = math.floor(lines * 0.88),

		row = math.floor(lines * 0.06),
		col = math.floor(columns - (columns * 0.38) - 2),

		border = "rounded",
		title = " 󰚩  Copilot Chat ",
		title_pos = "center",
		zindex = 60,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "copilot-chat",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.cursorline = false
		vim.opt_local.list = false
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.conceallevel = 2
		vim.opt_local.winblend = 0
	end,
})

vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "CopilotChatBorder", { bg = "NONE", fg = "#6c7086" })

local function set_copilot_chat_transparency()
	vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "CopilotChatBorder", { bg = "NONE", fg = "#6c7086" })

	-- esses dois são OBRIGATÓRIOS
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
end

-- roda agora
set_copilot_chat_transparency()

-- roda sempre que trocar colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_copilot_chat_transparency,
})
