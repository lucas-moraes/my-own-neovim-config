---@diagnostic disable: undefined-global

vim.lsp.start({
	name = "ts_ls",
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }),
})

vim.lsp.start({
	name = "cssls",
	cmd = { "vscode-css-language-server", "--stdio" },
	root_dir = vim.fs.root(0, { "package.json", ".git" }),
})

vim.lsp.start({
	name = "html",
	cmd = { "vscode-html-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { "package.json", ".git" }),
})

vim.lsp.start({
	name = "lua_ls",
	cmd = { "lua-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { ".git" }),
})

vim.lsp.start({
  name = "tailwindcss",
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_dir = vim.fs.root(0, { "tailwind.config.js", "package.json", ".git" }),
})

