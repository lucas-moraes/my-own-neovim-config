# 🚀 Neovim Config
This is my personal Neovim configuration, written entirely in Lua. It is designed to provide a fast, robust, and modern development experience, specifically optimized for TypeScript and JavaScript ecosystems. It includes full Debugging (DAP) support and seamless integration with CLI power tools.

### ✨ Key Features
- Fullstack Optimized: Fine-tuned for React, Node.js, and modern web development.
- Plugin Management: Powered by Packer.nvim for a modular and fast setup.
- Advanced Debugging: Pre-configured DAP (Debug Adapter Protocol) located in the /debugger directory.
- AI-Powered: Built-in support for GitHub Copilot.
- Terminal Integration: Smooth workflow with LazyGit, LazyDocker, and Zellij.

</br>

<video src="https://github.com/user-attachments/assets/12f8240f-6a16-47d7-8cad-026f10cdb465"></video>

### 🛠️ Third party plugins:
- Packer.nvim: https://github.com/wbthomason/packer.nvim (Required)
- FiraCore Nerd Font: https://www.nerdfonts.com/font-downloads (Required)
- LazyGit: https://github.com/jesseduffield/lazygit (Optional)
- LazyDocker: https://github.com/jesseduffield/LazyDocker (Optional)
- Zellij: https://zellij.dev/ (Optional)
- Copilot: https://github.com/github/copilot.vim (Optional)

### Configurations dependencies:

- Node.js: We need to install Node.js to use some plugins like prettier, etc.
- C compiler: ```bash sudo apt-get install build-essential```

### 📥 How to install:
```bash
# 1. Clone the repository
git clone https://github.com/lucas-moraes/neovim-config.git

# 2. Move it to your Neovim configuration directory
# For Linux/macOS:
mkdir -p ~/.config
mv neovim-config ~/.config/nvim

# 3. Launch Neovim
nvim init.lua
```



## 🔌Core Plugins Core 
**LSP**: Ready-to-use configs for TypeScript, ESLint, and JSON.</br>
**Prettier**: Automatic code formatting on save.</br>
**DAP**: Integrated debugger for Node.js/TypeScript environments.</br>
**Treesitter**: Advanced syntax highlighting and code folding.</br>










