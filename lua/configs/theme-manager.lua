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

-- Salva o nome do tema em arquivo
local function save_theme(name)
  local f = io.open(theme_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

-- Lê o tema salvo, ou retorna "dracul" como padrão
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

-- Aplica o tema e lualine
function M.apply_theme(name)
  local success_theme = pcall(function()
    require("themes." .. name).setup()
  end)

  local success_lualine = pcall(function()
    require("configs.lualine." .. name)
  end)

  if success_theme and success_lualine then
    vim.notify("🎨 Tema ativado: " .. name, vim.log.levels.INFO)
    save_theme(name)
  else
    vim.notify("❌ Erro ao aplicar o tema: " .. name, vim.log.levels.ERROR)
  end
end

-- Interface para escolher o tema
function M.select_theme()
  vim.ui.select(M.themes, { prompt = "Selecione o tema:" }, function(choice)
    if choice then
      M.apply_theme(choice)
    end
  end)
end

-- Comando :ThemeSelect
vim.api.nvim_create_user_command("ThemeSelect", M.select_theme, {})

-- Aplica o último tema salvo (ou dracul)
M.apply_theme(load_last_theme())

return M

