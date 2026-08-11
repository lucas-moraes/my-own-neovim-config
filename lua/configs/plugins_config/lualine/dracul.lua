local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#282a36",
  buffer_active_bg = "#ff79c6",
  buffer_inactive_fg = "#bd93f9",
  buffer_inactive_bg = "#282a36",
  winbar_left_fg = "#44475a",
  winbar_fg = "#f8f8f2",
  theme = {
    normal = {
      a = { fg = "#282a36", bg = "#bd93f9", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#44475a" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    insert = {
      a = { fg = "#282a36", bg = "#50fa7b", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#44475a" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    visual = {
      a = { fg = "#282a36", bg = "#ff79c6", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#44475a" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    replace = {
      a = { fg = "#282a36", bg = "#ff5555", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#44475a" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    command = {
      a = { fg = "#282a36", bg = "#8be9fd", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#44475a" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
    inactive = {
      a = { fg = "#f8f8f2", bg = "#282a36", gui = "bold" },
      b = { fg = "#f8f8f2", bg = "#282a36" },
      c = { fg = "#f8f8f2", bg = "#282a36" },
    },
  },
})
