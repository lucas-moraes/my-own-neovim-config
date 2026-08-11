local status, ls = pcall(require, "luasnip")

if not status then
	return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	ls.add_snippets(ft, {
		s("cl", {
			t({ "console.log(" }),
			i(1),
			t({ ")" }),
		}),
	})
end

for _, ft in ipairs({ "javascriptreact", "typescriptreact" }) do
	ls.add_snippets(ft, {
		s("raf", {
			t({ "export default function " }),
			i(1, "Component"),
			t({ "() {", "\treturn " }),
			i(2),
			t({ "", "}" }),
		}),
		s("styled", {
			t({ "import styled from 'styled-components';", "" }),
			t({ "export const " }),
			i(1, "Component"),
			t({ " = styled." }),
			i(2, "div"),
			t({ "`", "\t", "`;", "" }),
		}),
	})
end
