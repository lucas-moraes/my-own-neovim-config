-- Auto-instala o packer se necessário
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd [[packadd packer.nvim]]
    _G.packer_bootstrap = true
    return true
  end
  return false
end

ensure_packer()


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


-- Carregando plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {}
    end
  }

  if _G.packer_bootstrap then
    require('packer').sync()
  end
end)

-- Seus outros requires
require("settings")
require("plugins")
require("maps")
