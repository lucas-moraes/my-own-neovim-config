# 🚀 Neovim Config

This is my personal Neovim configuration, written entirely in Lua. It is designed to provide a fast, robust, and modern development experience, optimized for TypeScript, JavaScript, and **Rust** ecosystems. It includes full Debugging (DAP) support and seamless integration with CLI power tools.

### ✨ Key Features

- Fullstack Optimized: Fine-tuned for React, Node.js, and modern web development.
- **Rust Development**: Full support with rust-tools.nvim, rust-analyzer LSP, codelldb debugging, and Cargo.toml integration.
- Plugin Management: Powered by Lazy.nvim for a fast, modern, and efficient setup.
- Advanced Debugging: Pre-configured DAP (Debug Adapter Protocol) located in the /debugger directory.
- AI-Powered: Built-in support for GitHub Copilot and OpenCode integration.
- Terminal Integration: Smooth workflow with LazyGit, LazyDocker, and Zellij.
- Theme Manager: 7 curated themes with interactive theme selection via `:ThemeSelect`.
- File Explorer: Neo-tree for intuitive file navigation and management.
- LSP Support: Ready-to-use configs for TypeScript, JavaScript, **Rust**, HTML, CSS, Tailwind, and Lua.
- Advanced Folding: UFO (nvim-ufo) for intelligent code folding with Treesitter integration.
- Markdown Preview: Live preview for markdown files with `:MarkdownPreview`.

</br>

<video src="https://github.com/user-attachments/assets/12f8240f-6a16-47d7-8cad-026f10cdb465"></video>

### 🛠️ Third party plugins:

- Lazy.nvim: https://github.com/folke/lazy.nvim (Required - installed automatically)
- FiraCore Nerd Font: https://www.nerdfonts.com/font-downloads (Required)
- Ripgrep: https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation (Required)
- LazyGit: https://github.com/jesseduffield/lazygit (Optional)
- LazyDocker: https://github.com/jesseduffield/LazyDocker (Optional)
- Zellij: https://zellij.dev/ (Optional)
- Copilot: https://github.com/github/copilot.vim (Optional)
- OpenCode: https://github.com/NickvanDyke/opencode.nvim (Optional - AI coding assistant)

### Configurations dependencies:

- Node.js: Required for prettier, eslint, and some LSP servers
- C compiler: `sudo apt-get install build-essential` (for some Neovim plugins)
- stylua: Lua formatter (auto-installed via Mason)
- **Rust toolchain**: Install via [rustup](https://rustup.rs/) for Rust development
- **cargo**: Usually installed with Rust toolchain

### 📥 How to install:

```bash
# 1. Clone the repository
git clone https://github.com/lucas-moraes/neovim-config.git

# 2. Move it to your Neovim configuration directory
# For Linux/macOS:
mkdir -p ~/.config
mv neovim-config ~/.config/nvim

# 3. Launch Neovim - lazy.nvim will auto-install on first run
nvim

```

> **Note**: On first launch, lazy.nvim will automatically install itself and all configured plugins. This may take a few moments.

### 🔧 Auto-Configuration

The config includes smart auto-setup features:

- **Ripgrep**: Automatically installs via `apt` (Linux) or `brew` (macOS) if not detected
- **LSP Servers**: Mason auto-installs TypeScript, HTML, CSS, Lua, Tailwind, **Rust (rust-analyzer)**, and **TOML (taplo)** language servers
- **DAP Tools**: Mason-DAP auto-installs debugging adapters (including **codelldb for Rust**)
- **Theme Memory**: Last selected theme and lualine config are automatically restored
- **Format on Save**: Auto-formats Lua files with stylua, **Rust files with rustfmt**, and JS/TS files with prettier

## 🔌 Core Plugins

**LSP**: Ready-to-use configs for TypeScript, JavaScript, **Rust**, HTML, CSS, Tailwind, Lua.</br>
**Rust Tools**: rust-tools.nvim with enhanced rust-analyzer, debugging via codelldb, and Cargo.toml integration.</br>
**Prettier**: Automatic code formatting on save (Lua via stylua, **Rust via rustfmt**, others via prettier).</br>
**DAP**: Integrated debugger for Node.js/TypeScript/**Rust** environments with nvim-dap-ui.</br>
**Treesitter**: Advanced syntax highlighting and code folding.</br>
**Telescope**: Fuzzy finder for files, buffers, and text search.</br>
**Neo-tree**: Modern file explorer with git integration.</br>
**nvim-cmp**: Autocomplete with LSP, path, buffer, and snippet sources.</br>
**LuaSnip**: Snippet engine with friendly-snippets collection.</br>
**nvim-ufo**: Intelligent code folding with preview.</br>
**Gitsigns**: Git signs, blame, and hunk navigation.</br>
**ToggleTerm**: Integrated terminal with multiple layouts.</br>
**Lualine**: Status line with theme matching.</br>
**Which-key**: Keybinding hints and leader menu.</br>
**Markdown-preview**: Live markdown preview in browser.</br>
**Trouble**: Quick-fix list for diagnostics and LSP errors.</br>
**Smear-cursor**: Smooth cursor animations.</br>
**Colorizer**: Highlight color codes in files.</br>
**Transparent**: Transparency support for themes.</br>

## 🎨 Themes

Interactive theme selection with `<leader>ts` or `:ThemeSelect`:

- **moonlightness**: Elegant dark theme with pastel accents
- **dracul**: Modern take on the classic Dracula theme
- **dark-orange**: Warm dark theme with orange highlights
- **dark-purple**: Purple-themed dark aesthetic
- **nordic**: Inspired by Nord, cold and clean
- **light**: Clean light theme for daytime work
- **dark-transparent**: Dark theme with transparency support

Each theme includes matching Lualine configuration for a cohesive look. Theme preference is automatically saved and restored.

## 📦 Plugin Management Commands

Lazy.nvim provides a clean UI and useful commands:

- `:Lazy` - Open the lazy.nvim UI to manage plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing plugins and update existing ones
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for plugin updates
- `:Lazy restore` - Restore plugins to their lockfile state
- `:Lazy profile` - Show detailed profiling information

## ⌨️ Keybindings Overview

### File Navigation
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Live grep with Telescope
- `<leader>fb` - Grep in current buffer

#### Neo-tree (File Explorer)
When focused on Neo-tree:
- `<C-c>` - Copy relative path to clipboard
- `<C-v>` - Paste clipboard content to command line

### DAP Debugging
- `<leader>dc` - Continue debugging
- `<leader>do` - Step over
- `<leader>di` - Step into
- `<leader>dO` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>du` - Toggle DAP UI
- `<leader>dR` - Toggle REPL

### AI & Code Assistance
- `<leader>oa` - Ask OpenCode
- `<leader>ox` - Execute OpenCode action
- `<leader>ot` - Toggle OpenCode

### Buffer & Window Management
- `<leader>xx` - Close current buffer
- `<leader>xa` - Close all buffers
- `<leader>|` - Vertical split
- `<leader>-` - Horizontal split

### Theme & UI
- `<leader>ts` - Select theme interactively
- `<leader>zj` - Open all folds (UFO)
- `<leader>zc` - Close all folds (UFO)

### Terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal

### Git
- `<leader>lg` - Open LazyGit
- `<leader>gb` - Git blame line
- `<leader>gl` - Toggle line blame

### File Operations
- `<leader>w` - Save file
- `<leader>cf` - Format code

## 🦀 Rust Development

This configuration provides comprehensive Rust development support:

### Features
- **rust-tools.nvim**: Enhanced rust-analyzer integration with hover actions, runnables, and debuggables
- **rust-analyzer LSP**: Full language server support with advanced inlay hints
- **codelldb**: Native debugging support via Mason
- **crates.nvim**: Cargo.toml dependency management
- **taplo**: TOML language server for Cargo.toml
- **Auto-formatting**: rustfmt integration on save

### Keybindings
| Keybinding | Description |
|------------|-------------|
| `K` | Enhanced hover actions |
| `<leader>rr` | Run runnables (binaries, tests, examples) |
| `<leader>rd` | Debug debuggables |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Go to parent module |
| `<leader>rm` | Expand macro |
| `<leader>ca` | Code action group |
| `gd` / `gr` | Go to definition / Find references |
| `<leader>rn` | Rename symbol |
| `[d` / `]d` | Navigate diagnostics |

### Debugging
Debugging is configured via codelldb (auto-installed via Mason):
- Launch file: Debug a specific executable
- Launch cargo build: Auto-build and debug current package
- Attach to process: Attach to running process

Use `<leader>d` prefix for all DAP commands (see DAP Debugging section above).
