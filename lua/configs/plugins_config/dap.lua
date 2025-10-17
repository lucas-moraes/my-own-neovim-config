local dap = require("dap")
local dapui = require("dapui")

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

local function detect_ts_node()
	local local_path = vim.fn.getcwd() .. "/node_modules/.bin/ts-node"
	if vim.fn.executable(local_path) == 1 then
		return local_path
	elseif vim.fn.executable("ts-node") == 1 then
		return "ts-node"
	else
		return nil
	end
end

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			name = "Launch current file (Node)",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(), 
			runtimeExecutable = "node",
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**" },
		},
		{
			name = "Launch current file (ts-node)",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = detect_ts_node(),
			runtimeArgs = { "--transpile-only" },
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**" },
		},
	}
end

for name, sign in pairs({
	DapBreakpoint = "🔴",
	DapBreakpointCondition = "🟡",
	DapLogPoint = "📝",
	DapStopped = "➡️",
	DapBreakpointRejected = "⛔",
}) do
	vim.fn.sign_define(name, { text = sign, texthl = name, linehl = "", numhl = "" })
end
