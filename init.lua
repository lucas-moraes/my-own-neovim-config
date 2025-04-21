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
