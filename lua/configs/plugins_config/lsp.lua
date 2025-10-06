-- lsp.lua atualizado (compatível com nvim-lspconfig v3 e anteriores)

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local protocol = require("vim.lsp.protocol")

-- Função de attach padrão
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end

	-- Tooltip automático ao segurar o cursor
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
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
end

-- Capabilities padrão (autocompletar, etc)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Função auxiliar compatível com as duas APIs
local function setup_server(name, config)
	config = vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, config or {})

	if vim.lsp.config then
		-- Nova API (Neovim 0.11+)
		vim.lsp.start(vim.lsp.config({
			name = name,
			cmd = lspconfig[name].document_config.default_config.cmd,
			root_dir = lspconfig[name].document_config.default_config.root_dir,
			settings = config.settings,
			on_attach = config.on_attach,
			capabilities = config.capabilities,
		}))
	else
		-- API antiga (até nvim-lspconfig 2.x)
		lspconfig[name].setup(config)
	end
end

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

	vim.lsp.buf_request(0, "textDocument/definition", util.make_position_params(), function(err, result, ctx, config)
		if err then
			vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
			return
		end

		local filtered = filter_node_modules(result)
		if vim.tbl_isempty(filtered) then
			vim.notify("Nenhuma definição encontrada fora de node_modules.", vim.log.levels.WARN)
			return
		end

		util.jump_to_location(filtered[1], "utf-8")
	end)
end

-- Configuração dos servidores
setup_server("ts_ls", {
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>CodeActionMenu<CR>", opts)
		vim.keymap.set("n", "<leader>gd", goto_definition_filtered, { buffer = bufnr, noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end,
})

setup_server("cssls")
setup_server("tailwindcss")
setup_server("intelephense")
