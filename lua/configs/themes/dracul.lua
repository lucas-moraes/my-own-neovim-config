---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"

  local dracula = {
    bg = "#282a36",
    fg = "#f8f8f2",
    comment = "#6272a4",
    red = "#ff5555",
    orange = "#ffb86c",
    yellow = "#f1fa8c",
    green = "#50fa7b",
    cyan = "#8be9fd",
    blue = "#6272a4",
    magenta = "#bd93f9",
    pink = "#ff79c6",
    black = "#21222c",
    white = "#f8f8f2",
    gray = "#44475a",
  }

  vim.api.nvim_set_hl(0, "Normal", { bg = dracula.bg, fg = dracula.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = dracula.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = dracula.bg, bg = dracula.bg })

  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
  vim.api.nvim_set_hl(0, "Whitespace", { fg = dracula.gray })
  vim.api.nvim_set_hl(0, "NonText", { fg = dracula.gray })

  vim.api.nvim_set_hl(0, "CursorLine", { bg = dracula.black })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = dracula.black })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = dracula.black })
  vim.api.nvim_set_hl(0, "LineNr", { fg = dracula.comment })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dracula.yellow })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = dracula.white, bg = dracula.gray })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = dracula.comment, bg = dracula.black })
  vim.api.nvim_set_hl(0, "TabLine", { fg = dracula.white, bg = dracula.black })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = dracula.black })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = dracula.black, bg = dracula.pink })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = dracula.gray })

  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = dracula.magenta, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = dracula.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = dracula.white })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = dracula.white })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = dracula.white })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = dracula.green })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = dracula.orange })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = dracula.red })
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = dracula.red })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = dracula.gray })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = dracula.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = dracula.white, bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = dracula.black })
  vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = dracula.pink })

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = dracula.comment, italic = true })

  local function set_many(defs)
    for group, opts in pairs(defs) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  set_many({
    Keyword = { fg = dracula.pink },
    Function = { fg = dracula.green },
    Parameter = { fg = dracula.white },
    String = { fg = dracula.yellow },
    Type = { fg = dracula.cyan },
    Number = { fg = dracula.orange },
    Boolean = { fg = dracula.orange },
    Operator = { fg = dracula.magenta },
    Comment = { fg = dracula.comment, italic = true },
    Constant = { fg = dracula.cyan },
    PreProc = { fg = dracula.pink },
    Error = { fg = dracula.bg, bg = dracula.red, bold = true },
    Property = { fg = dracula.white },
    Identifier = { fg = dracula.magenta },
    Delimiter = { fg = dracula.comment },
    PunctuationBracket = { fg = dracula.comment },
    Special = { fg = dracula.cyan },
    Conditional = { fg = dracula.pink },
    Repeat = { fg = dracula.pink },
    Statement = { fg = dracula.pink },
    Variable = { fg = dracula.pink },
  })

  set_many({
    typescriptTypeReference = { fg = dracula.cyan, italic = true },
    typescriptTypeParameter = { fg = dracula.orange, italic = true },
    typescriptInterfaceName = { fg = dracula.cyan, bold = true },
    typescriptEnumName = { fg = dracula.cyan },
    typescriptIdentifier = { fg = dracula.cyan },
    typescriptVariable = { fg = dracula.green },
    typescriptProp = { fg = dracula.yellow },
    typescriptFunction = { fg = dracula.green },
    typescriptMethod = { fg = dracula.green },
    typescriptCall = { fg = dracula.green },
    typescriptDecorator = { fg = dracula.orange },
    typescriptReserved = { fg = dracula.pink },
    typescriptStatement = { fg = dracula.pink },
    typescriptKeyword = { fg = dracula.pink },
    typescriptOperator = { fg = dracula.magenta },
    typescriptArrowFunc = { fg = dracula.magenta },
  })

  set_many({
    tsxTagName = { fg = dracula.pink },
    tsxComponentName = { fg = dracula.magenta, bold = true },
    tsxCloseString = { fg = dracula.comment },
    tsxAttrib = { fg = dracula.green, italic = true },
    tsxTag = { fg = dracula.magenta },
    tsxCloseTag = { fg = dracula.magenta },
    tsxEqual = { fg = dracula.pink },
    tsxEscapedContent = { fg = dracula.yellow },
    tsxBraces = { fg = dracula.white },
  })

  set_many({
    htmlTag = { fg = dracula.fg },
    htmlEndTag = { fg = dracula.fg },
    htmlTagName = { fg = dracula.pink },
    htmlSpecialTagName = { fg = dracula.pink },
    htmlArg = { fg = dracula.green, italic = true },
    htmlLink = { fg = dracula.cyan, underline = true },
    htmlString = { fg = dracula.yellow },
  })

  set_many({
    cssTagName = { fg = dracula.pink },
    cssClassName = { fg = dracula.green },
    cssIdentifier = { fg = dracula.orange },
    cssSelectorOp = { fg = dracula.pink },
    cssProp = { fg = dracula.cyan },
    cssAttr = { fg = dracula.orange },
    cssUnitDecorators = { fg = dracula.pink },
    cssColor = { fg = dracula.magenta },
  })

  set_many({
    javaScriptReserved = { fg = dracula.pink },
    javaScriptConditional = { fg = dracula.pink },
    javaScriptRepeat = { fg = dracula.pink },
    javaScriptOperator = { fg = dracula.pink },
    javaScriptFunction = { fg = dracula.green },
    javaScriptIdentifier = { fg = dracula.magenta },
    javaScriptGlobal = { fg = dracula.cyan },
    javaScriptMember = { fg = dracula.orange },
    javaScriptBraces = { fg = dracula.fg },
    javaScriptParens = { fg = dracula.fg },
  })

  set_many({
    luaFunctionCall = { fg = dracula.green },
    luaTable = { fg = dracula.yellow },
    pythonBuiltin = { fg = dracula.cyan },
    pythonStatement = { fg = dracula.pink },
    jsonKeyword = { fg = dracula.pink },
    yamlPlainScalar = { fg = dracula.yellow },
  })
end

return theme
