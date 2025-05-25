require("mason").setup()
require("mason-nvim-dap").setup({
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

dap.adapters.python = {
	type = "executable",
	command = os.getenv("HOME") .. "/.virtualenvs/nvim-python/bin/python", -- ajuste para seu venv
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch arquivo atual",
		program = "${file}",
		pythonPath = function()
			return os.getenv("HOME") .. "/.virtualenvs/nvim-python/bin/python" -- ajuste aqui também
		end,
	},
}
