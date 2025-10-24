vim.env.PATH = os.getenv("PATH")

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

local debugger_path = vim.fn.expand("~/.config/nvim/debugger/vscode-js-debug")

require("dap-vscode-js").setup({
	debugger_path = debugger_path,
	adapters = { "pwa-node" },
})

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = { debugger_path .. "/out/src/dapDebugServer.js", "${port}" },
  },
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	dap.configurations[language] = {
		{
			name = "🧩 Attach TSX (porta 9229)",
			type = "pwa-node",
			request = "attach",
			port = 9229,
			address = "127.0.0.1",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
        "!**/.git/**",
			},
			pauseForSourceMap = true,
			sourceMapPathOverrides = {
				["webpack:///./~/*"] = "${workspaceFolder}/node_modules/*",
				["webpack:///./*"] = "${workspaceFolder}/*",
				["webpack:///*"] = "*",
				["*/src/*"] = "${workspaceFolder}/src/*",
				["../*"] = "${workspaceFolder}/*",
			},
			skipFiles = { "<node_internals>/**" },
			attachExistingChildren = true,
		},
	}
end

for name, sign in pairs({
	DapBreakpoint = "🔴",
	DapBreakpointCondition = "🟡",
	DapBreakpointRejected = "⛔",
	DapLogPoint = "🪵",
	DapStopped = "➡️",
	DapBreakpointDisabled = "⚪",
}) do
	vim.fn.sign_define(name, { text = sign, texthl = name })
end
