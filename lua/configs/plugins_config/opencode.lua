---@diagnostic disable: undefined-global

local status, opencode = pcall(require, "opencode")

if not status then
	return
end

-- Setup opencode.nvim
opencode.setup({
	-- Default editor to use when opening files
	-- Options: "vscode", "sublime_text", "atom", "code-insiders"
	editor = "vscode",
	
	-- Open in current window or new instance
	new_instance = false,
	
	-- Additional arguments to pass to the editor
	args = {},
	
	-- Enable verbose logging for debugging
	verbose = false,
})
