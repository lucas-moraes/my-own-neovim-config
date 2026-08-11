local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#1e2030",
  buffer_active_bg = "#82aaff",
  buffer_inactive_fg = "#7a88cf",
  buffer_inactive_bg = "#2d2e3e",
  winbar_left_fg = "#44475a",
  winbar_fg = "#c8d3f5",
  theme = {
    normal = {
      a = { fg = "#1e2030", bg = "#82aaff", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#2d2e3e" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
    insert = {
      a = { fg = "#1e2030", bg = "#c3e88d", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#2d2e3e" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
    visual = {
      a = { fg = "#1e2030", bg = "#ff966c", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#2d2e3e" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
    replace = {
      a = { fg = "#1e2030", bg = "#c099ff", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#2d2e3e" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
    command = {
      a = { fg = "#1e2030", bg = "#86e1fc", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#2d2e3e" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
    inactive = {
      a = { fg = "#c8d3f5", bg = "#1e2030", gui = "bold" },
      b = { fg = "#c8d3f5", bg = "#1e2030" },
      c = { fg = "#c8d3f5", bg = "#1e2030" },
    },
  },
})
