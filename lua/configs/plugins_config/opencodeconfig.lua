---@diagnostic disable: undefined-global
local status, opencode = pcall(require, "opencode")

if not status then
	return
end

vim.g.opencode_opts = {
  events = {
    reload = true,
  },
  ui = {
    position = "right",
  },
}

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		local provider = opencode.provider
		if provider and provider.stop then
			pcall(provider.stop, provider)
		end
	end,
})
