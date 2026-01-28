-- Auto-instala o lazy.nvim se necessário
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ripgrep
local function ensure_ripgrep()
	local handle = io.popen("which rg")
	local result = handle:read("*a")
	handle:close()

	if result == "" then
		print("Instalando ripgrep...")

		local os_name = vim.loop.os_uname().sysname

		if os_name == "Linux" then
			vim.fn.system({ "sudo", "apt", "install", "-y", "ripgrep" })
		elseif os_name == "Darwin" then
			vim.fn.system({ "brew", "install", "ripgrep" })
		else
			vim.notify("Ripgrep não instalado: sistema não suportado", vim.log.levels.ERROR)
		end
	end
end

ensure_ripgrep()

-- ripgrep
require("configs.main.settings")
require("configs.main.plugins")
require("configs.main.maps")
