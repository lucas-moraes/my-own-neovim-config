local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#3a2d22",
  buffer_active_bg = "#ffaf40",
  buffer_inactive_fg = "#b0aba6",
  buffer_inactive_bg = "#3a2d22",
  winbar_left_fg = "#61564e",
  winbar_fg = "#b0aba6",
  theme = {
    normal = {
      a = { fg = "#ffb44c", bg = "#995900", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#663b00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
    insert = {
      a = { fg = "#104c00", bg = "#00ff95", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#663b00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
    visual = {
      a = { fg = "#4c4100", bg = "#9500ff", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#663b00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
    replace = {
      a = { fg = "#ffb44c", bg = "#7f2a2a", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#663b00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
    command = {
      a = { fg = "#663b00", bg = "#95daff", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#663b00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
    inactive = {
      a = { fg = "#ffb44c", bg = "#190e00", gui = "bold" },
      b = { fg = "#ffb44c", bg = "#190e00" },
      c = { fg = "#ffb44c", bg = "#190e00" },
    },
  },
})
