vim.env.PATH = os.getenv("PATH")

local status_dap, dap = pcall(require, "dap")
if not status_dap then
  return
end

local status_dapui, dapui = pcall(require, "dapui")
if status_dapui then
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
end

local status_virtual_text, virtual_text = pcall(require, "nvim-dap-virtual-text")
if status_virtual_text then
  virtual_text.setup()
end

-- Codelldb adapter (installed via Mason)
local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
local codelldb_path = nil

if mason_registry_ok and mason_registry.is_installed("codelldb") then
  local codelldb = mason_registry.get_package("codelldb")
  local extension_path = codelldb:get_install_path() .. "/extension/"
  codelldb_path = extension_path .. "adapter/codelldb"
end

-- Fallback to system paths if Mason codelldb not found
if not codelldb_path then
  codelldb_path = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb")
end

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
  {
    name = "Launch cargo build",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Build first
      vim.fn.system("cargo build")
      -- Get package name from Cargo.toml
      local cargo_toml = vim.fn.getcwd() .. "/Cargo.toml"
      if vim.fn.filereadable(cargo_toml) == 0 then
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end
      local cargo_content = vim.fn.readfile(cargo_toml)
      local package_name = nil
      for _, line in ipairs(cargo_content) do
        local name = line:match('^name%s*=%s*"([^"]+)"')
        if name then
          package_name = name
          break
        end
      end
      if package_name then
        return vim.fn.getcwd() .. "/target/debug/" .. package_name
      end
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

-- DAP signs
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DiagnosticSignInfo",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DiagnosticSignOk",
  linehl = "DapStoppedLine",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DiagnosticSignHint",
  linehl = "",
  numhl = "",
})

-- Highlight for stopped line
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3d4220" })
