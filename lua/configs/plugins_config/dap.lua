local mason = require("mason")
local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason.setup()
mason_dap.setup({
	ensure_installed = { "js-debug-adapter" },
	automatic_setup = true,
	handlers = {},
})
dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter",
		args = { "${port}" },
	},
}

require("nvim-dap-virtual-text").setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.configurations = dap.configurations or {}
dap.configurations.typescript = {
	{
		name = "Attach to NestJS",
		type = "pwa-node",
		request = "attach",
		processId = require("dap.utils").pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
	},
}
dap.configurations.javascript = dap.configurations.typescript

dap.adapters["node"] = dap.adapters["pwa-node"]

for name, sign in pairs({
	DapBreakpoint = "🔴",
	DapBreakpointCondition = "🟡",
	DapLogPoint = "📝",
	DapStopped = "➡️",
	DapBreakpointRejected = "⛔",
}) do
	vim.fn.sign_define(name, { text = sign, texthl = name, linehl = "", numhl = "" })
end
