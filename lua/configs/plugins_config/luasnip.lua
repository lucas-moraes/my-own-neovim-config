local status, ls = pcall(require, "luasnip")

if not status then
	return
end

local s = ls.snippet
local t = ls.text_node

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

-- React default function
ls.add_snippets("javascriptreact", {
	s(">rdf", {
		t({ "export default function ReactDefaultFunction() {", "  return (<div></div>);", "}" }),
	}),
})

-- React default function
ls.add_snippets("typescriptreact", {
	s(">rdf", {
		t({ "export default function ReactDefaultFunction() {", "  return (<div>, </div>);", "}" }),
	}),
})

-- React arrow function
ls.add_snippets("javascriptreact", {
	s(">raf", {
		t({ "export default const ReactArrowFunction = () => {", "  return (<div></div>);", "}" }),
	}),
})

-- React arrow function
ls.add_snippets("typescriptreact", {
	s(">raf", {
		t({ "export default const ReactArrowFunction = () => {", "  return (<div>, </div>);", "}" }),
	}),
})

-- React function
ls.add_snippets("javascriptreact", {
	s(">f", {
		t({ "export function ReactFunction() {", " console.log('hi');", "}" }),
	}),
})

-- React function
ls.add_snippets("typescriptreact", {
	s(">f", {
		t({ "export function ReactFunction() :void {", "  console.log('hi');", "}" }),
	}),
})

-- console log
ls.add_snippets("javascriptreact", {
	s(">cl", {
		t({ "console.log(`=>`, 'hi')" }),
	}),
})

-- console log
ls.add_snippets("typescriptreact", {
	s(">cl", {
		t({ "console.log(`=>`, 'hi')" }),
	}),
})

-- Mapeamento para expandir ou pular para o próximo placeholder no modo de inserção
vim.api.nvim_set_keymap(
	"i",
	"<S-Tab>",
	"v:lua.require'luasnip'.expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, noremap = true, silent = true }
)
