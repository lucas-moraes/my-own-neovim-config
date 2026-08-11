local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#2e3440",
  buffer_active_bg = "#81a1c1",
  buffer_inactive_fg = "#a3be8c",
  buffer_inactive_bg = "#3b4252",
  winbar_left_fg = "#4c566a",
  winbar_fg = "#e5e9f0",
  theme = {
    normal = {
      a = { fg = "#2e3440", bg = "#81a1c1", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#4c566a" },
      c = { fg = "#d8dee9", bg = "#3b4252" },
    },
    insert = {
      a = { fg = "#2e3440", bg = "#a3be8c", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#4c566a" },
      c = { fg = "#d8dee9", bg = "#3b4252" },
    },
    visual = {
      a = { fg = "#2e3440", bg = "#d08770", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#4c566a" },
      c = { fg = "#d8dee9", bg = "#3b4252" },
    },
    replace = {
      a = { fg = "#2e3440", bg = "#bf616a", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#4c566a" },
      c = { fg = "#d8dee9", bg = "#3b4252" },
    },
    command = {
      a = { fg = "#2e3440", bg = "#88c0d0", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#4c566a" },
      c = { fg = "#d8dee9", bg = "#3b4252" },
    },
    inactive = {
      a = { fg = "#d8dee9", bg = "#2e3440", gui = "bold" },
      b = { fg = "#d8dee9", bg = "#2e3440" },
      c = { fg = "#d8dee9", bg = "#2e3440" },
    },
  },
})
