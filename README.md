## My own neovim configuration

### This configuration is focused to TypeScript, JavaScript.

### Third party plugins:

- LazyGit: https://github.com/jesseduffield/lazygit
- LazyDocker: https://github.com/jesseduffield/LazyDocker
- Packer.nvim: https://github.com/wbthomason/packer.nvim


### Configurations dependencies:

- Node.js: We need to install Node.js to use some plugins like biome, prettier, etc.
- Pip: We need to install pip to use some plugins like flake8, black, etc.

```bash
pyright: npm install -g pyright
flake8 and black: pip install flake8 black
```
### How to install:

- Install neovim
- Clone this repository in your home directory.
- Rename the folder to .config/neovim
- Open neovim and key <space> + ps to install plugins
- close and open neovim again

### Principals commands:

- `<space> + ps`: Install and sync plugins
- `<space> + qa`: Close all buffers
- `<space> + cc`: Close current buffer
- `<space> + wa`: Save all files
- `<space> + w`: Save current file
- `<space> + q`: Quit neovim
