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

for name, sign in pairs({
	DapBreakpoint = "🔴",
	DapBreakpointCondition = "🟡",
	DapBreakpointRejected = "⛔",
	DapLogPoint = "🪵",
	DapStopped = "→ ",
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

local function get_python_path()
	local cwd = vim.fn.getcwd()
	local venvs = { "venv", ".venv", ".env", "env" }
	for _, venv in ipairs(venvs) do
		local path = cwd .. "/" .. venv .. "/bin/python"
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
	return "python"
end

dap.configurations.python = {
	{
		name = "Launch file",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = get_python_path,
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
		pythonPath = get_python_path,
	},
	{
		name = "Django: runserver",
		type = "python",
		request = "launch",
		program = "${workspaceFolder}/manage.py",
		args = { "runserver", "0.0.0.0:8000" },
		django = true,
		pythonPath = get_python_path,
	},
	{
		name = "Flask: run",
		type = "python",
		request = "launch",
		module = "flask",
		env = {
			FLASK_APP = "${workspaceFolder}/app.py",
			FLASK_DEBUG = "1",
		},
		args = { "run", "--no-debugger", "--no-reload" },
		pythonPath = get_python_path,
	},
	{
		name = "Pytest: current file",
		type = "python",
		request = "launch",
		module = "pytest",
		args = {
			"${file}",
			"-v",
		},
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},
	{
		name = "Pytest: current function",
		type = "python",
		request = "launch",
		module = "pytest",
		args = function()
			local file = vim.fn.expand("%:p")
			local line = vim.fn.line(".")
			return { file, "-v", "-k", line }
		end,
		console = "integratedTerminal",
		pythonPath = get_python_path,
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
