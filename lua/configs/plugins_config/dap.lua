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
			name = "Launch file",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			name = "Launch ts-node (current file)",
			type = "pwa-node",
			request = "launch",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "npx",
			runtimeArgs = { "ts-node", "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			name = "Attach to process (port 9229)",
			type = "pwa-node",
			request = "attach",
			port = 9229,
			address = "127.0.0.1",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			restart = true,
			protocol = "inspector",
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			sourceMapPathOverrides = {
				["webpack:///./~/*"] = "${workspaceFolder}/node_modules/*",
				["webpack:///./*"] = "${workspaceFolder}/*",
				["webpack:///*"] = "*",
				["${workspaceFolder}/*"] = "${workspaceFolder}/*",
			},
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			name = "Attach to process (port 9230)",
			type = "pwa-node",
			request = "attach",
			port = 9230,
			address = "127.0.0.1",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			restart = true,
			protocol = "inspector",
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			sourceMapPathOverrides = {
				["webpack:///./~/*"] = "${workspaceFolder}/node_modules/*",
				["webpack:///./*"] = "${workspaceFolder}/*",
				["webpack:///*"] = "*",
				["${workspaceFolder}/*"] = "${workspaceFolder}/*",
			},
			skipFiles = { "<node_internals>/**", "node_modules/**" },
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

-- Python DAP configuration (debugpy)
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		name = "Launch file",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "python"
			end
		end,
	},
	{
		name = "Launch file with arguments",
		type = "python",
		request = "launch",
		program = "${file}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " +")
		end,
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "python"
			end
		end,
	},
	{
		name = "Attach to remote",
		type = "python",
		request = "attach",
		connect = {
			host = "127.0.0.1",
			port = 5678,
		},
	},
}
