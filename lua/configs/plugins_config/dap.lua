require("mason").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "pwa-node" },
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

-- Configuração do adaptador pwa-node (js-debug-adapter)
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "js-debug-adapter", -- Deve ser instalado via Mason ou manualmente
		args = { "${port}" },
	},
}

-- Configuração para depuração de TypeScript com ts-node
dap.configurations.typescript = {
	{
		name = "Debug com ts-node via node --inspect-brk",
		type = "pwa-node", -- Usa o adaptador moderno pwa-node
		request = "launch",
		runtimeExecutable = "ts-node", -- Executa diretamente o ts-node
		runtimeArgs = { "--inspect" }, -- Habilita o modo de depuração
		program = "${file}", -- Arquivo a ser depurado
		cwd = vim.fn.getcwd(), -- Diretório de trabalho atual
		console = "integratedTerminal", -- Usa o terminal integrado do Neovim
		sourceMaps = true, -- Habilita source maps para TypeScript
		protocol = "inspector", -- Protocolo moderno do Node.js
		skipFiles = { "<node_internals>/**", 'node_modules/**' }, -- Ignora arquivos internos do Node.js
	},
}

dap.configurations.javascript = dap.configurations.typescript

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
