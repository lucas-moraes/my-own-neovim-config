local status, ls = pcall(require, "luasnip")

if not status then
	return
end

local s = ls.snippet
local t = ls.text_node

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	ls.add_snippets(ft, {
		s(">cl", { t({ "console.log(`=>`, 'hi')" }) }),
	})
end

for _, ft in ipairs({ "javascriptreact", "typescriptreact" }) do
	ls.add_snippets(ft, {
		s(">raf", {
			t({ "export function ReactFunction() {", " console.log('hi');", "}" }),
		}),
	})
end

-- Mapeamento para expandir ou pular para o próximo placeholder no modo de inserção
vim.api.nvim_set_keymap(
	"i",
	"<S-Tab>",
	"v:lua.require'luasnip'.expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, noremap = true, silent = true }
)
