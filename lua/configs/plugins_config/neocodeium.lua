local status, neocodeium = pcall(require, "neocodeium")
if not status then
  return
end

neocodeium.setup({
  enabled = true,
  manual = false,
  show_label = true,
  debounce = false,
  max_lines = 10000,
  silent = true,
  filter = function(bufnr)
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok and cmp.visible() then
      return false
    end
    return true
  end,
  filetypes = {
    help = false,
    gitcommit = false,
    gitrebase = false,
    ["."] = false,
    markdown = false,
    yaml = false,
  },
})

vim.keymap.set("i", "<M-Enter>", function()
  neocodeium.accept()
end)

vim.keymap.set("i", "<M-w>", function()
  neocodeium.accept_word()
end)

vim.keymap.set("i", "<M-]>", function()
  neocodeium.cycle_or_complete()
end)

vim.keymap.set("i", "<C-]>", function()
  neocodeium.clear()
end)