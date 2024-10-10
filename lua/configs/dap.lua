local dap = require('dap')

-- Configuração básica de exemplo para Node.js (usando `vscode-node-debug2`)
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.config/nvim/vscode-js-debug-1.94.0/src/build/jsDebugCustom.js'},
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.configurations.typescript = dap.configurations.javascript
