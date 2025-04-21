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

-- Configuração do DAP para Node (ts-node)
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"
  },
}

dap.configurations.typescript = {
  {
    name = "Debug com ts-node via node --inspect-brk",
    type = "node2",
    request = "launch",
    runtimeExecutable = "node",
    args = { "./node_modules/.bin/ts-node", "${file}" },
    cwd = vim.fn.getcwd(),
    console = "integratedTerminal",
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**" },
  }
}


dap.configurations.javascript = dap.configurations.typescript
