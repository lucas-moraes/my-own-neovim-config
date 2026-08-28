# AGENTS.md

Personal Neovim config (Lua), TS/JS-focused. No build/test suite — validate by opening nvim (`:Lazy` healthy, `:checkhealth`, plugins load clean).

## Layout
- Entry: `init.lua` → `configs.main.{settings,plugins,maps}` (that order).
- Plugin lazy specs: only `lua/configs/main/plugins.lua` (declarative). Per-plugin setup: `lua/configs/plugins_config/<name>.lua`.
- Themes: `lua/configs/themes/<name>.lua` (`.setup()`) + matching lualine in `lua/configs/plugins_config/lualine/<name>.lua` (thin wrappers over `lualine/common.lua`).
- Theme manager is **not** a lazy plugin: required at bottom of `plugins.lua` after `lazy.setup`.
- Utils: `lua/utils/init.lua` (path copy helpers). DAP binary: `debugger/vscode-js-debug/` (path hardcoded in `dap.lua` to `~/.config/nvim/debugger/vscode-js-debug`).
- Lockfile: `lazy-lock.json` — commit when plugin versions change.
- Ignore: `.env`, `plugin/` (stale packer compile), `pack/`. Do not commit secrets.

## Commands / verify
- Plugins: `:Lazy` | `:Lazy sync` | `:Lazy update` | `:Lazy clean` | `:Lazy restore`. Leader: `<leader>ll/ls/lc/lu`.
- Format: `:Format` / `:FormatWrite`. Format-on-save is a `BufWritePost` augroup **inside** `formatter.lua` (not a separate file).
  - Lua → `stylua --search-parent-directories`
  - JS/TS/JSX/TSX/HTML/CSS/SCSS/LESS/JSON/Prisma/MD → `npx prettier` (print-width 120, tab-width 2)
  - On-save globs: `*.css,*.prisma,*.js,*.ts,*.json,*.html,*.scss,*.less,*.md,*.lua` — **no** `*.tsx`/`*.jsx` (filetype formatters exist; save-hook does not cover those extensions).
- Manual format map: `<leader>cf` → `:Format` (does not write; on-save uses `FormatWrite`).

## Gotchas agents miss
- `init.lua` side effects: clones lazy.nvim if missing; auto-installs `rg` via `brew` (macOS) / `apt` (Linux). Keep ripgrep install — Telescope depends on it.
- LSP: `plugins_config/lsp.lua` sets `vim.lsp.config` + cmp capabilities; mason-lspconfig auto-enables servers (`ts_ls`, `cssls`, `html`, `lua_ls`, `tailwindcss`). cmp source must be `nvim_lsp` (not `lsp`) for auto-imports.
- DAP is **attach-only**: one config, "Attach ts-node (port 9229)", `pwa-node`, sourceMaps on. Target process must start with `--inspect=9229`. No launch config.
- Folding: nvim-ufo + treesitter `foldexpr` (`foldlevelstart=99`). Maps: `<leader>zj` open all, `<leader>zc` close all.
- **Normal-mode `e` is remapped to `i`** in `maps.lua`. Do not “fix” this unless asked.
- Buffer close (`<leader>xx` / `<leader>xa`) calls `configs.plugins_config.lualine.common` helpers — not raw `:bd`.
- `<leader>p` = go-to-definition filtering out `node_modules` (which-key desc is wrong/stale).
- Treesitter `ensure_installed` lives in `plugins_config/treesitter.lua`; keep in sync when adding languages.
- `plugin/packer_compiled.lua` is leftover/gitignored — not part of runtime path for this config.

## AI
- Completion: **minuet-ai.nvim** (`plugins_config/minuet.lua`) via DeepInfra FIM (`deepseek-ai/DeepSeek-V4-Flash`). Not Copilot, not Codeium/neocodeium — do not re-add those.
- Needs `DEEPINFRA_API_KEY`. Loaded from `stdpath("config")/.env` by minuet (see `.env-example`). File is gitignored.
- Virtual-text accept maps: `<M-Enter>` accept, `<M-l>` line, `<C-]>` dismiss (see minuet.lua).
- OpenCode: `NickvanDyke/opencode.nvim`, `plugins_config/opencodeconfig.lua` (UI `right`, provider stopped on `VimLeave`). Maps `<leader>o*`: `oa` ask, `ox` select action, `ot` toggle, `ou`/`od` scroll, `ol`/`op` operator.

## Theming
- 7 themes: moonlightness, dracul, dark-orange, dark-purple, nordic, light, dark-transparent — each needs **both** theme + lualine file with the same name.
- `:ThemeSelect` / `<leader>ts` applies both and persists to `stdpath("cache")/last_theme.txt` + `last_lualine.txt`. Default fallback: `dracul`.
- New theme = add `themes/<name>.lua` + `lualine/<name>.lua` calling `common.setup({...})` + append name to `theme-manager.lua` `M.themes`.

## Lua conventions (this repo)
- 2-space indent, double quotes, trailing commas in tables.
- Optional requires: `pcall` + early return.
- Cache `vim.g` / `vim.o` / `vim.diagnostic` at module top when used heavily.
- One augroup per concern, `clear = true`.
- Keymaps: which-key `wk.add({ ... })` in `maps.lua`, grouped by concern.
- `---@diagnostic disable: undefined-global` file header when vim globals are bare.
- No gratuitous comments.

## UX defaults worth not “fixing”
- Leader: space. `relativenumber = false`. `termguicolors`. Diagnostics: virtual_text on, severity_sort, rounded floats.
