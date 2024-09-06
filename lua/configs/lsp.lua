local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- JavaScript / TypeScript
nvim_lsp.ts_ls.setup({
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }

		-- Mapear Ctrl+. para abrir o menu de ações de código
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>CodeActionMenu<CR>", opts)

		-- Mapeamento para ir para a definição (usando <leader>gd)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

		-- Mapeamento para mostrar informações sobre o símbolo (usando <leader>K)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

		-- Mapeamento para renomear (usando <leader>rn)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end,
})

-- CSS
nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Tailwind
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- PHP
nvim_lsp.intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
