local M = {}

function M.setup() 
  vim.api.nvim_create_user_command("QuickNotes", function() 
    require("quicknotes.ui").open()
  end)
end

return M
