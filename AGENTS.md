# AGENTS.md

Personal Neovim configuration written in Lua, tuned for TypeScript/JavaScript with full DAP debugging and AI integration. No build or automated test suite exists; validate manually inside Neovim.

## Quick Facts
- Entry point: `init.lua` requires `configs.main.{settings,plugins,maps}` in that order.
- Core configs: `lua/configs/main/` (settings.lua, plugins.lua, maps.lua)
- Plugin configs: `lua/configs/plugins_config/` — one file per plugin, lazily loaded via lazy.nvim
- Themes: `lua/configs/themes/` (palette + `.setup()`) each paired with a lualine variant in `lua/configs/plugins_config/lualine/`
- Debugger: `debugger/vscode-js-debug/` (resolved from `~/.config/nvim` via `dap.lua`)
- Shared util: `lua/utils/init.lua` (copy path helpers)
- Lockfile: `lazy-lock.json` pins plugin versions; commit it when versions change.

## Plugin Management (Lazy.nvim)
- `:Lazy` GUI | `:Lazy sync` | `:Lazy update` | `:Lazy clean` | `:Lazy check` | `:Lazy restore`
- Leader shortcuts: `<leader>ll` Lazy, `<leader>ls` sync, `<leader>lc` clean, `<leader>lu` update
- All plugin lazy specs live in `lua/configs/main/plugins.lua`, ordered by concern; keep them declarative.

## Build / Lint / Test
- No tests. Sanity-check by opening nvim: plugins load error-free, `:Lazy` shows healthy, `:checkhealth` passes.
- Formatting is the "lint". Manual run: `:Format` (writes buffer) or `:FormatWrite`. Format-on-save also fires via `BufWritePost` (augroup defined inside `formatter.lua`).
- Filetypes & tools (`lua/configs/plugins_config/formatter.lua`):
  - Lua → `stylua` (search-parent-directories)
  - JS/TS/JSX/TSX/HTML/CSS/SCSS/LESS/JSON/Prisma/Markdown → `prettier` via `npx` (print-width 120, tab-width 2)
  - On-save pattern: `*.css, *.prisma, *.js, *.ts, *.json, *.html, *.scss, *.less, *.md, *.lua`

## Architecture Gotchas
- `init.lua` has side effects: if lazy.nvim is missing it clones it; if `rg` is absent it runs `brew install ripgrep` (macOS) or `apt install ripgrep` (Linux). Don't remove ripgrep auto-install — Telescope/LSP depend on it.
- Folding is driven by **nvim-ufo** (`<leader>z` open/close all folds), layered on treesitter `foldexpr` set in settings.lua (`foldmethod=expr`, `foldlevelstart=99`).
- DAP is **attach-only**: `dap.lua` defines a single configuration, "Attach ts-node (port 9229)" (pwa-node, sourceMaps on). There is no launch/spawn config. To add one you must define a `request = "launch"` configuration yourself.
- Format-on-save augroup lives inside `formatter.lua` (not a standalone augroup file), despite AGENTS-style guidance suggesting one.

## Code Style (Lua)
- 2-space indent, no tabs; double quotes only; trailing commas in tables.
- Locals use snake_case; dirs kebab-case; table keys snake_case unless the plugin API expects camelCase.
- Wrap optional `require`s in `pcall` and return early on failure (guards Copilot-era, neocodeium, transparent, themes, etc.). Reference APIs that may be missing only through pcall.
- Cache vim APIs locally (`vim.g`, `vim.o`, `vim.diagnostic`) at top of module.
- Autocommands: one augroup per concern with `clear = true`.
- Keymaps declared via which-key `wk.add({ ... })` in `maps.lua`; keep grouped by concern.
- Comments `--` only for non-obvious intent; no gratuitous comments.
- Add `---@diagnostic disable: undefined-global` file header when globals are used.

## AI & Integrations
- **Completion is neocodeium** (`monkoose/neocodeium`, config in `plugins_config/neocodeium.lua`) — GitHub Copilot was replaced by Codeium (git: "replace copilot by codeium"). Do NOT re-add copilot.vim references; the README is stale here.
- OpenCode: `NickvanDyke/opencode.nvim`, config `plugins_config/opencodeconfig.lua` (UI position `right`, provider stopped on VimLeave). Keymaps under `<leader>o*` (`oa` ask, `ox` execute, `ot` toggle, `ou`/`od` scroll).

## LSP & DAP Tooling
- Mason auto-installs: `ts_ls`, `cssls`, `html`, `lua_ls`, `tailwindcss`. LSP diagnostics: virtual text on, signs `//`, `severity_sort`, rounded float borders.
- DAP adapter path must resolve to `~/.config/nvim/debugger/vscode-js-debug`; pwa-node default attach port 9229, source maps for TS/JS. DAP keymaps under `<leader>d*` (`dc` continue, `do` step over, `du` UI toggle, etc.).
- Treesitter parsers in `plugins_config/treesitter.lua` (`ensure_installed`) should stay in sync with languages in README.

## Theming
- 7 themes: moonlightness, dracul, dark-orange, dark-purple, nordic, light, dark-transparent. Each has a matching lualine variant of the same name.
- `:ThemeSelect` (or `<leader>ts`) interactively applies a theme + its lualine variant. Last selection is remembered in `stdpath("cache")` files (`last_theme.txt`, `last_lualine.txt`); default fallback is `dracul`.

## UX Defaults
- Leader: space. Absolute line numbers on (`relativenumber = false`). `termguicolors` true. Tree-sitter-based folding.
