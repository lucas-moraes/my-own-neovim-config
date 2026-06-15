---@diagnostic disable: undefined-global

local status, markview = pcall(require, "markview")
if not status then
	return
end

markview.setup({
	modes = { "n", "no" },
	hybrid_modes = { "n" },
})