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
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
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

nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})
