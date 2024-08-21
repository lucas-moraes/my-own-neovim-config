local status, ls = pcall(require, "luasnip")

if not status then
	return
end

local s = ls.snippet
local t = ls.text_node

-- React default function
ls.add_snippets("javascriptreact", {
	s("rdf", {
		t({ "export default function ReactDefaultFunction() {", "  return (<div></div>;", "}" }),
	}),
})

-- React default function
ls.add_snippets("typescriptreact", {
	s("rdf", {
		t({ "export default function ReactDefaultFunction() {", "  return (<div>, </div>);", "}" }),
	}),
})

-- React arrow function
ls.add_snippets("javascriptreact", {
	s("raf", {
		t({ "export default const ReactArrowFunction = () => {", "  return (<div></div>);", "}" }),
	}),
})

-- React arrow function
ls.add_snippets("typescriptreact", {
	s("raf", {
		t({ "export default const ReactArrowFunction = () => {", "  return (<div>, </div>);", "}" }),
	}),
})

-- Mapeamento para expandir ou pular para o próximo placeholder no modo de inserção
vim.api.nvim_set_keymap(
	"i",
	"<S-Tab>",
	"v:lua.require'luasnip'.expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, noremap = true, silent = true }
)
