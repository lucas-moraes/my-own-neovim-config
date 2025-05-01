require("mason").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "node2" },
	automatic_setup = true,
})
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap = require("dap")
local dapui = require("dapui")

-- UI automática
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.rust = {
	{
		name = "Debug Rust",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

vim.fn.sign_define("DapBreakpoint", {
	text = "🔴",
	texthl = "DiagnosticSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "🟡",
	texthl = "DiagnosticSignWarn",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
	text = "📝",
	texthl = "DiagnosticSignInfo",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "➡️",
	texthl = "DiagnosticSignInfo",
	linehl = "Visual",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "⛔",
	texthl = "DiagnosticSignHint",
	linehl = "",
	numhl = "",
})
