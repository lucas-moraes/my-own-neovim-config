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

-- Python snippets
ls.add_snippets("python", {
	s("$-cl", {
		t({ "print(f\"{" }),
		t({ "", "}\")" }),
	}),
	s("$-main", {
		t({ "if __name__ == \"__main__\":", "    " }),
	}),
	s("$-class", {
		t({ "class ClassName:", "    " }),
	}),
	s("$-def", {
		t({ "def function_name():", "    " }),
	}),
	s("$-deco", {
		t({ "@decorator", "def function_name():", "    " }),
	}),
	s("$-prop", {
		t({ "@property", "def name(self):", '    """The name property."""', "    return self._name" }),
	}),
	s("$-datac", {
		t({ "from dataclasses import dataclass", "", "@dataclass", "class ClassName:", "    " }),
	}),
	s("$-imp", {
		t({ "import " }),
	}),
	s("$-impf", {
		t({ "from  import ", "" }),
	}),
	s("$-type", {
		t({ "from typing import TypeAlias", "", "TypeAlias = " }),
	}),
})

-- Mapeamento para expandir ou pular para o próximo placeholder no modo de inserção
vim.api.nvim_set_keymap(
	"i",
	"<S-Tab>",
	"v:lua.require'luasnip'.expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, noremap = true, silent = true }
)
