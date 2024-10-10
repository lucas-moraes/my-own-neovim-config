local status, dap = pcall(require, "dap")
if not status then
	return
end

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch arquivo",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Anexar ao processo",
    processId = require("dap.utils").pick_process,
    cwd = vim.fn.getcwd(),
  }
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch arquivo TS",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    outFiles = { "${workspaceFolder}/dist/**/*.js" },
    console = "integratedTerminal",
  }
}


