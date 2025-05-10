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

vim.api.nvim_create_autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			border = "rounded",
			source = "always", 
			header = "", -- sem cabeçalho extra
			prefix = "", -- sem pré-fixos
		})
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function goto_definition_filtered()
	local util = vim.lsp.util

	local function filter_node_modules(results)
		if not results then
			return {}
		end
		return vim.tbl_filter(function(result)
			local uri = result.uri or result.targetUri
			return not uri:match("node_modules")
		end, results)
	end

	vim.lsp.buf_request(
		0,
		"textDocument/definition",
		vim.lsp.util.make_position_params(),
		function(err, result, ctx, config)
			if err then
				vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
				return
			end

			local filtered_result = filter_node_modules(result)
			if vim.tbl_isempty(filtered_result) then
				vim.notify("Nenhuma definição encontrada fora de node_modules.", vim.log.levels.WARN)
				return
			end

			util.jump_to_location(filtered_result[1], "utf-8")
		end
	)
end

-- JavaScript / TypeScript
nvim_lsp.ts_ls.setup({
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }

		-- Mapear Ctrl+. para abrir o menu de ações de código
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>CodeActionMenu<CR>", opts)

		-- Mapeamento para ir para a definição (usando <leader>gd)
		vim.keymap.set("n", "<leader>gd", goto_definition_filtered, { buffer = bufnr, noremap = true, silent = true })

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
