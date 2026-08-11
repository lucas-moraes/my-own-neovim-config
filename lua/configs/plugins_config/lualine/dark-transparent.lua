local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#ffffff",
  buffer_active_bg = "#5f00af",
  buffer_inactive_fg = "#999999",
  buffer_inactive_bg = "#3a3a3a",
  winbar_left_fg = "#3a3a3a",
  winbar_fg = "#999999",
  theme = {
    normal = {
      a = { fg = "#f8f8f2", bg = "#5e497c", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#3b4048" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    insert = {
      a = { fg = "#104c00", bg = "#38ff00", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#3b4048" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    visual = {
      a = { fg = "#4c4100", bg = "#ffd900", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#3b4048" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    replace = {
      a = { fg = "#f8f8f2", bg = "#7f2a2a", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#3b4048" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    command = {
      a = { fg = "#f8f8f2", bg = "#375d65", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#3b4048" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    inactive = {
      a = { fg = "#6272a4", bg = "#282a36", gui = "bold" },
      b = { fg = "#6272a4", bg = "#282a36" },
      c = { fg = "#6272a4", bg = "#282a36" },
    },
  },
})
