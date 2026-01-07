# AGENTS.md

This repository is a personal Neovim configuration written in Lua, optimized for TypeScript/JavaScript development with full DAP debugging support.

## Build/Lint/Test Commands

This is a configuration repository with no traditional build/test pipeline. Code is formatted on save:

- **Lua formatting**: Uses `stylua` (configured in formatter.nvim)
- **JS/TS/JSON/HTML/CSS formatting**: Uses `prettier` via npx (configured in formatter.nvim)
- **Formatting trigger**: Auto-formats on BufWritePost for *.lua, *.js, *.ts, *.tsx, *.json, *.html, *.css, *.scss, *.md, *.prisma

Manual formatting: `:Format` or `:FormatWrite`

Plugin management commands:
- `:Lazy` - Open Lazy.nvim UI
- `:Lazy sync` - Install/update plugins
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins

## Code Style Guidelines

### General Structure
- Main entry point: `init.lua`
- Core configs: `lua/configs/main/` (settings.lua, plugins.lua, maps.lua)
- Plugin configs: `lua/configs/plugins_config/`
- Theme configs: `lua/configs/themes/`

### Lua Code Style

**Indentation**: 2 spaces (never tabs)
```lua
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
```

**File Header**: Add diagnostic disable at top
```lua
---@diagnostic disable: undefined-global
```

**Module Pattern**: Use pcall with status checking
```lua
local status, module = pcall(require, "module_name")
if not status then
  return
end
```

**Local Caching**: Cache vim APIs for performance
```lua
local global = vim.g
local o = vim.o
local d = vim.diagnostic
```

**Naming Conventions**:
- Variables: snake_case (e.g., `local has_words_before`)
- Functions: snake_case (e.g., `function set_copilot_chat_transparency()`)
- Module names: kebab-case directories (e.g., `plugins_config/`)
- Keys in tables: snake_case or camelCase depending on plugin API

**String Literals**: Always use double quotes
```lua
local path = "~/.config/nvim"
vim.cmd("highlight clear")
```

**Tables**: Use comma-separated key-value pairs, trailing comma recommended
```lua
local nord = {
  bg = "#242933",
  fg = "#d8dee9",
  comment = "#616e88",
}
```

**Comments**: Use `--` for single-line, sparse usage (comment when non-obvious)
```lua
-- Auto-install ripgrep if not present
local function ensure_ripgrep()
```

**Error Handling**:
- Always wrap requires with pcall
- Check module status before using
- Return early if module unavailable
- Use vim.notify for user-facing messages with proper log levels

**Autocommands**: Use vim.api.nvim_create_autocmd with augroups
```lua
vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.lua" },
  command = "FormatWrite",
  group = "FormatAutogroup",
})
```

**Keybindings**: Use which-key.nvim for organized groups
```lua
wk.add({
  { "<leader>f", group = "Telescope" },
  { "<leader>ff", telescope.find_files, desc = "Telescope Find Files" },
})
```

**Highlight Groups**: Use vim.api.nvim_set_hl with table syntax
```lua
vim.api.nvim_set_hl(0, "Normal", { bg = nord.bg, fg = nord.fg })
vim.api.nvim_set_hl(0, "Comment", { fg = nord.comment, italic = true })
```

**Plugin Setup**:
- Define setup function at top level
- Use function() require() end pattern for lazy loading
- Configure in dedicated files under plugins_config/
- Main plugin list in lua/configs/main/plugins.lua

**Theme Configuration**:
- Define color palette as local table
- Use vim.o.background = "dark" or "light"
- Clear highlights before setting: `vim.cmd("syntax reset")`
- Return theme module at end

**LSP/DAP Config**:
- DAP debugger path: `~/.config/nvim/debugger/vscode-js-debug`
- Attach configuration uses pwa-node adapter on port 9229
- Source maps enabled for TypeScript
- Configured for ts_ls, cssls, html, lua_ls, tailwindcss

**File Organization**:
- Keep configs modular - one file per plugin when possible
- Shared utilities in main configs
- Theme-specific overrides in theme files
- Lazy-lock.json tracks plugin versions

**Neovim API Usage**:
- Prefer `vim.api.nvim_*` over deprecated `vim.*` when available
- Use `vim.fn.expand()` for path expansion
- Use `vim.env` for environment variables

No tests are present in this configuration repository. Changes should be manually verified by opening Neovim and checking functionality.
