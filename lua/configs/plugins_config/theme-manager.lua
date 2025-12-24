-- theme-manager.lua

local M = {}

M.themes = {
	"moonlightness",
	"dracul",
	"dark-orange",
	"dark-purple",
	"nordic",
	"light",
	"dark-transparent",
}

local theme_file = vim.fn.stdpath("cache") .. "/last_theme.txt"
local lualine_file = vim.fn.stdpath("cache") .. "/last_lualine.txt"

-- Salva o nome do tema visual
local function save_theme(name)
	local f = io.open(theme_file, "w")
	if f then
		f:write(name)
		f:close()
	end
end

-- Salva o nome do tema do lualine
local function save_lualine(name)
	local f = io.open(lualine_file, "w")
	if f then
		f:write(name)
		f:close()
	end
end

-- Carrega o tema visual salvo ou retorna "dracul" como padrão
local function load_last_theme()
	local f = io.open(theme_file, "r")
	if f then
		local theme = f:read("*l")
		f:close()
		return theme or "dracul"
	else
		return "dracul"
	end
end

-- Carrega o tema do lualine salvo ou retorna "dracul" como padrão
local function load_last_lualine()
	local f = io.open(lualine_file, "r")
	if f then
		local lualine = f:read("*l")
		f:close()
		return lualine or "dracul"
	else
		return "dracul"
	end
end

-- Aplica visual + lualine e salva os nomes
function M.apply_theme(theme_name, lualine_name)
	theme_name = theme_name or load_last_theme()
	lualine_name = lualine_name or load_last_lualine()

	local success_theme = pcall(function()
		require("configs.themes." .. theme_name).setup()
	end)

	local success_lualine = pcall(function()
		require("configs.plugins_config.lualine." .. lualine_name)
	end)

	if success_theme and success_lualine then
		vim.notify("🎨 Tema aplicado: " .. theme_name .. " | Lualine: " .. lualine_name, vim.log.levels.INFO)
		save_theme(theme_name)
		save_lualine(lualine_name)
	else
		vim.notify("❌ Erro ao aplicar tema ou lualine", vim.log.levels.ERROR)
	end
end

-- Interface interativa para escolher tema
function M.select_theme()
	vim.ui.select(M.themes, { prompt = "Selecione o tema:" }, function(choice)
		if choice then
			M.apply_theme(choice, choice) -- aplica tema + lualine com o mesmo nome
		end
	end)
end

-- Comando :ThemeSelect
vim.api.nvim_create_user_command("ThemeSelect", M.select_theme, {})

-- Aplica automaticamente o últ:mo tema salvo (ou fallback dracul)
M.apply_theme()

return M
