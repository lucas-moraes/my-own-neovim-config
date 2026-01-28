---@diagnostic disable: undefined-global

local M = {}

local fn = vim.fn
local uv = vim.loop or vim.uv

---Get the absolute path of a file
---@param path string The file path (relative or absolute)
---@return string|nil absolute_path The absolute path, or nil if resolution fails
---@return string|nil error Error message if resolution fails
function M.get_absolute_path(path)
  if not path or path == "" then
    return nil, "Path is empty or nil"
  end

  -- If already absolute, normalize and return
  if path:sub(1, 1) == "/" then
    local resolved = uv.fs_realpath(path)
    if resolved then
      return resolved
    end
    -- File might not exist yet, return normalized path
    return fn.fnamemodify(path, ":p")
  end

  -- Handle ~ (home directory)
  if path:sub(1, 1) == "~" then
    local expanded = fn.expand(path)
    local resolved = uv.fs_realpath(expanded)
    if resolved then
      return resolved
    end
    return fn.fnamemodify(expanded, ":p")
  end

  -- Relative path: resolve from current working directory
  local cwd = uv.cwd()
  local full_path = cwd .. "/" .. path

  -- Try to get real path (resolves symlinks, normalizes)
  local resolved = uv.fs_realpath(full_path)
  if resolved then
    return resolved
  end

  -- File might not exist yet, return normalized path
  return fn.fnamemodify(full_path, ":p")
end

---Get the absolute path of the current buffer's file
---@return string|nil absolute_path The absolute path, or nil if no file
function M.get_current_file_absolute_path()
  local bufname = fn.expand("%:p")
  if bufname == "" then
    return nil, "No file in current buffer"
  end
  return bufname
end

---Get the absolute path of a file relative to the Neovim config directory
---@param path string The path relative to config directory
---@return string absolute_path The absolute path
function M.get_config_path(path)
  local config_dir = fn.stdpath("config")
  if not path or path == "" then
    return config_dir
  end
  return config_dir .. "/" .. path
end

---Get absolute path from current context (Neo-tree or buffer)
---@return string|nil path The absolute path, or nil if not available
function M.get_context_path()
  local path = nil

  -- Check if we're in a Neo-tree window
  local filetype = vim.bo.filetype
  if filetype == "neo-tree" then
    local state_status, manager = pcall(require, "neo-tree.sources.manager")
    if state_status then
      local state = manager.get_state("filesystem")
      local node = state.tree:get_node()
      if node then
        path = node:get_id()
      end
    end
  else
    -- Regular buffer: get current file path
    local bufname = fn.expand("%:p")
    if bufname ~= "" then
      path = bufname
    end
  end

  return path
end

---Copy absolute path from current context to clipboard
---Works in both Neo-tree and regular buffers
function M.copy_absolute_path()
  local path = M.get_context_path()

  if path then
    fn.setreg("+", path)
    vim.notify("Copied: " .. path, vim.log.levels.INFO)
  else
    vim.notify("No file to copy path from", vim.log.levels.WARN)
  end
end

return M
