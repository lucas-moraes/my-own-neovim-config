local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#ffffff",
  buffer_active_bg = "#5f00af",
  buffer_inactive_fg = "#606060",
  buffer_inactive_bg = "#afafaf",
  winbar_left_fg = "#3a3a3a",
  winbar_fg = "#999999",
  theme = {
    normal = {
      a = { fg = "#282a36", bg = "#bd93f9", gui = "bold" },
      b = { fg = "#282a36", bg = "#d7befb" },
      c = { fg = "#282a36", bg = "#ebdefd" },
    },
    insert = {
      a = { fg = "#282a36", bg = "#50fa7b", gui = "bold" },
      b = { fg = "#282a36", bg = "#96fcaf" },
      c = { fg = "#282a36", bg = "#dcfee4" },
    },
    visual = {
      a = { fg = "#282a36", bg = "#ffb86c", gui = "bold" },
      b = { fg = "#282a36", bg = "#ffdbb5" },
      c = { fg = "#282a36", bg = "#fff0e1" },
    },
    replace = {
      a = { fg = "#282a36", bg = "#ff5555", gui = "bold" },
      b = { fg = "#282a36", bg = "#ff9999" },
      c = { fg = "#282a36", bg = "#ffdddd" },
    },
    command = {
      a = { fg = "#282a36", bg = "#8be9fd", gui = "bold" },
      b = { fg = "#282a36", bg = "#c5f4fe" },
      c = { fg = "#282a36", bg = "#e7fafe" },
    },
    inactive = {
      a = { fg = "#f8f8f2", bg = "NONE", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "NONE" },
      c = { fg = "#f8f8f2", bg = "NONE" },
    },
  },
})
