AGENTS.md

This repo is a personal Neovim configuration written in Lua, optimized for Python development with full DAP debugging.

## Quick Facts
- Entry point: `init.lua`
- Core configs: `lua/configs/main/` (settings.lua, plugins.lua, maps.lua)
- Plugin configs: `lua/configs/plugins_config/`
- Theme configs: `lua/configs/themes/`
- Lockfile: `lazy-lock.json` pins plugin versions

## Build / Lint / Test
- No traditional build or automated test suite; manual verification inside Neovim.
- Formatting:
  - Python: `ruff format` via formatter.nvim
  - Lua: `stylua` via formatter.nvim
- Format-on-save: BufWritePost for *.lua, *.py
- Manual format: `:Format` (writes buffer) or `:FormatWrite`
- Validate by opening Neovim and exercising features (LSP attach, DAP session, formatter trigger).

## Plugin Management (Lazy.nvim)
- `:Lazy` open UI
- `:Lazy sync` install/update
- `:Lazy update` update all
- `:Lazy clean` remove unused
- `:Lazy check` inspect updates
- `:Lazy restore` restore lockfile state
- Keep `lazy-lock.json` committed when plugin versions change.

## Dependencies & Tooling
- Required: Python 3, pip (for Ruff, pyright, debugpy), ripgrep, Nerd Font (FiraCore recommended)
- Optional but supported: lazygit, lazydocker, zellij
- Mason auto-installs LSP servers (pyright, ruff, lua_ls) and DAP adapter (debugpy)

## Code Style (Lua)
- Indent: 2 spaces, no tabs
- File header: add `---@diagnostic disable: undefined-global` when globals are used
- Strings: double quotes only
- Tables: trailing comma preferred
- Imports: wrap requires with pcall and return early on failure
```lua
local status, module = pcall(require, "module_name")
if not status then
  return
end
```
- Cache vim APIs locally for speed
```lua
local global = vim.g
local o = vim.o
local d = vim.diagnostic
```
- Naming: snake_case for locals/functions; directory names kebab-case; table keys snake_case unless plugin API expects camelCase
- Comments: use `--` sparingly for non-obvious intent
- Error handling: guard optional plugins with pcall; use `vim.notify(msg, vim.log.levels.WARN/ERROR)` for user-visible issues; return early when prerequisites fail
- Autocommands: create augroup per concern and set `clear = true`
```lua
local group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.lua", "*.py" },
  command = "FormatWrite",
  group = group,
})
```
- Keymaps: prefer which-key grouped declarations
```lua
local wk = require("which-key")
wk.add({
  { "<leader>f", group = "Telescope" },
  { "<leader>ff", telescope.find_files, desc = "Find files" },
})
```
- Highlights: set via `vim.api.nvim_set_hl(0, name, opts)` with tables
```lua
vim.api.nvim_set_hl(0, "Normal", { bg = nord.bg, fg = nord.fg })
```

## Code Style (Plugins & Config Layout)
- One file per plugin in `lua/configs/plugins_config/`; avoid monoliths
- Main plugin list lives in `lua/configs/main/plugins.lua`; keep lazy specs declarative and ordered by concern
- Theme modules define palettes locally, clear highlights with `vim.cmd("syntax reset")`, set `vim.o.background`, and return a table
- Shared utilities stay in main configs; avoid cross-import cycles between plugin configs
- Keep mappings in `lua/configs/main/maps.lua`; keep core options in `lua/configs/main/settings.lua`

## Formatting & Imports
- Let formatter.nvim drive ruff format / stylua; avoid manual whitespace tweaks that fight formatters
- Do not mix single/double quotes; always double
- Prefer local requires over global side effects; avoid `vim.cmd("packadd ...")` unless necessary
- For treesitter, ensure parsers in `lua/configs/plugins_config/treesitter.lua` list stay in sync with languages mentioned in README

## Types & Annotations
- Use `---@diagnostic disable` only when needed; keep scope minimal
- LuaLS annotations welcome for plugin APIs when clarity helps (e.g., `---@type table<string, string>`), but keep concise

## Error Handling & Notifications
- Guard optional dependencies (Copilot, OpenCode, transparent, theme modules) with pcall
- When a plugin config fails, return early; avoid hard errors during startup
- User-facing issues should call `vim.notify` with meaningful messages and log levels

## Debugging (DAP)
- Python debugger via debugpy (installed by Mason)
- Adapter auto-detects venv/.venv/.env python path
- Configurations: Launch file, Launch with args, Django runserver, Flask run, Pytest (file/function), Attach remote (port 5678)
- Verify DAP UI bindings in `maps.lua` (continue, step, toggle UI, REPL)

## LSP
- Servers: pyright, ruff, lua_ls configured via mason
- Prefer `on_attach` to set buffer-local keymaps; keep capabilities in sync with nvim-cmp setup
- Diagnostics: virtual text enabled, signs set to `//`; severity_sort on; floating windows rounded borders

## UX Defaults
- Leader: space; relative numbers on; termguicolors true
- Folding via treesitter (`foldmethod=expr`, `foldexpr=nvim_treesitter#foldexpr()`, `foldlevelstart=99`)
- Fillchars for folds set; custom Folded/FoldColumn highlights

## Theming
- Themes in `lua/configs/themes/` with matching lualine variants under `lua/configs/plugins_config/lualine/`
- Last selected theme remembered by theme manager; `:ThemeSelect` provides interactive choice
- Transparency supported via `dark-transparent` theme option
- All themes include Python-specific highlight groups (pythonFunction, pythonMethod, pythonClass, pythonDecorator, pythonSelf, pythonDocstring)

## AI Helpers
- Copilot plugin configured in `lua/configs/plugins_config/copilot.lua`; no additional org-wide Copilot rules present
- OpenCode integration present (`lua/configs/plugins_config/opencodeconfig.lua`); keymaps under `<leader>o*`

## Repo Hygiene
- Keep files ASCII; double quotes; 2-space indent
- Do not introduce new diagnostics without guards; prefer early returns on missing deps
- When updating plugins, regenerate `lazy-lock.json`
- No tests to run; sanity-check by opening Neovim, running `:Lazy`, `:checkhealth`, and triggering formatter on save

## Not Present
- Cursor rules: none (.cursor/ or .cursorrules absent)
- Copilot org rules: none in .github/copilot-instructions.md

## Verification Checklist (manual)
- Launch nvim: plugins load without errors
- Run `:Lazy` and ensure plugins are healthy
- Open Python file: LSP attaches (pyright + ruff), formatting on save runs ruff format
- Open Lua file: stylua formats on save
- Run a DAP session against Python: debugpy adapter works
- Switch theme with `:ThemeSelect`: lualine and colors update and persist
