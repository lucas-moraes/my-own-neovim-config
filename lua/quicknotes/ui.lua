local M = {}

function M.open()
  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_win_set_option(win, "winhighlight", "Normal:QuickNotesFloat,FloatBorder:Title")

  vim.fn.termopen(vim.fn.stdpath("config") .. "/lua/quicknotes/bin/quicknotes", {
    on_exit = function(_, code, _)
      if code == 0 then
        vim.schedule(function()
          vim.api.nvim_win_close(win, true)
        end)
      end
    end,
  })

  vim.cmd("startinsert")
end

return M

