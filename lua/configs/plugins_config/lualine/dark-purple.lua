local common = require("configs.plugins_config.lualine.common")

common.setup({
  buffer_active_fg = "#34004c",
  buffer_active_bg = "#b000ff",
  buffer_inactive_fg = "#a799ad",
  buffer_inactive_bg = "#34004c",
  winbar_left_fg = "#4e325b",
  winbar_fg = "#b0aba6",
  theme = {
    normal = {
      a = { fg = "#b000ff", bg = "#58007f", gui = "bold" },
      b = { fg = "#b000ff", bg = "#34004c" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
    insert = {
      a = { fg = "#34004c", bg = "#00ff04", gui = "bold" },
      b = { fg = "#b000ff", bg = "#34004c" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
    visual = {
      a = { fg = "#34004c", bg = "#fdff00", gui = "bold" },
      b = { fg = "#b000ff", bg = "#34004c" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
    replace = {
      a = { fg = "#b000ff", bg = "#ff00c1", gui = "bold" },
      b = { fg = "#b000ff", bg = "#34004c" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
    command = {
      a = { fg = "#34004c", bg = "#00dfff", gui = "bold" },
      b = { fg = "#b000ff", bg = "#34004c" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
    inactive = {
      a = { fg = "#b000ff", bg = "#110019", gui = "bold" },
      b = { fg = "#b000ff", bg = "#110019" },
      c = { fg = "#b000ff", bg = "#110019" },
    },
  },
})
