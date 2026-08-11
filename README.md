# 🚀 Neovim Config

This is my personal Neovim configuration, written entirely in Lua. It is designed to provide a fast, robust, and modern development experience, specifically optimized for TypeScript and JavaScript ecosystems. It includes full Debugging (DAP) support and seamless integration with CLI power tools.

### ✨ Key Features

- Fullstack Optimized: Fine-tuned for React, Node.js, and modern web development.
- Plugin Management: Powered by Lazy.nvim for a fast, modern, and efficient setup.
- Advanced Debugging: Pre-configured DAP (Debug Adapter Protocol) located in the /debugger directory.
- AI-Powered: Built-in support for Codeium (neocodeium) and OpenCode integration.
- Terminal Integration: Smooth workflow with LazyGit, LazyDocker, and Zellij.
- Theme Manager: 7 curated themes with interactive theme selection via `:ThemeSelect`.
- File Explorer: Neo-tree for intuitive file navigation and management.
- LSP Support: Ready-to-use configs for TypeScript, JavaScript, HTML, CSS, Tailwind, and Lua.
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
- Codeium (neocodeium): https://github.com/monkoose/neocodeium (Optional - AI code completion)
- OpenCode: https://github.com/NickvanDyke/opencode.nvim (Optional - AI coding assistant)

### Configurations dependencies:

- Node.js: Required for prettier, eslint, and some LSP servers
- C compiler: `sudo apt-get install build-essential` (for some Neovim plugins)
- stylua: Lua formatter (auto-installed via Mason)

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
- **LSP Servers**: Mason auto-installs TypeScript, HTML, CSS, Lua, and Tailwind language servers
- **DAP Tools**: Mason-DAP auto-installs debugging adapters
- **Theme Memory**: Last selected theme and lualine config are automatically restored
- **Format on Save**: Auto-formats Lua files with stylua and JS/TS files with prettier

## 🔌 Core Plugins

**LSP**: Ready-to-use configs for TypeScript, JavaScript, HTML, CSS, Tailwind, Lua.</br>
**Prettier**: Automatic code formatting on save (Lua via stylua, others via prettier).</br>
**DAP**: Integrated debugger for Node.js/TypeScript environments with nvim-dap-ui.</br>
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

## ⌨️ Keybindings

### File Navigation
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Live grep with Telescope
- `<leader>fb` - Grep in current buffer

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
