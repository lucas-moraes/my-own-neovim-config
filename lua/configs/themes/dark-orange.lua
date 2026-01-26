---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"

  local orange = {
    bg = "#1f1b17",
    fg = "#ffcc80",
    comment = "#b25900",
    red = "#ff4500",
    orange = "#ff9500",
    yellow = "#ffeb99",
    green = "#ffcc80",
    cyan = "#ffebcc",
    blue = "#ffcc80",
    magenta = "#ff8000",
    black = "#2c251b",
    white = "#ffebcc",
    gray = "#3a2d22",
  }

  local function set_many(defs)
    for group, opts in pairs(defs) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  vim.api.nvim_set_hl(0, "Normal", { bg = orange.bg, fg = orange.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = orange.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = orange.bg, bg = orange.bg })

  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

  vim.api.nvim_set_hl(0, "Whitespace", { fg = orange.gray })
  vim.api.nvim_set_hl(0, "NonText", { fg = orange.gray })

  vim.api.nvim_set_hl(0, "CursorLine", { bg = orange.black })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = orange.gray })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = orange.gray })
  vim.api.nvim_set_hl(0, "LineNr", { fg = orange.yellow })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = orange.orange })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = orange.orange, bg = orange.gray })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = orange.orange, bg = orange.black })
  vim.api.nvim_set_hl(0, "TabLine", { fg = orange.white, bg = orange.black })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = orange.black })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = orange.white, bg = orange.gray })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = orange.orange, bg = "none" })

  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = orange.fg, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = orange.orange })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = orange.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = orange.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = orange.white })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = orange.orange })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = orange.orange })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = orange.orange })
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = orange.red })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = orange.gray })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = orange.fg })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = orange.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = orange.black })
  vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = orange.fg, bg = "none" })

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = orange.comment, italic = true })

  set_many({
    Keyword = { fg = orange.magenta },
    Function = { fg = orange.orange },
    Parameter = { fg = orange.fg },
    String = { fg = orange.yellow },
    Type = { fg = orange.fg },
    Number = { fg = orange.red },
    Boolean = { fg = orange.red },
    Operator = { fg = orange.orange },
    Comment = { fg = orange.comment, italic = true },
    Constant = { fg = orange.orange },
    PreProc = { fg = orange.orange },
    Error = { fg = orange.bg, bg = orange.red, bold = true },
    Property = { fg = orange.orange },
    Atributes = { fg = orange.orange },
    Tag = { fg = orange.magenta },
    Identifier = { fg = orange.orange },
    Delimiter = { fg = orange.orange },
    PunctuationBracket = { fg = orange.orange },
    Special = { fg = orange.orange },
  })

  set_many({
    typescriptTypeReference = { fg = orange.fg, italic = true },
    typescriptTypeParameter = { fg = orange.orange, italic = true },
    typescriptInterfaceName = { fg = orange.fg, bold = true },
    typescriptEnumName = { fg = orange.fg },
    typescriptIdentifier = { fg = orange.fg },
    typescriptVariable = { fg = orange.orange },
    typescriptProp = { fg = orange.yellow },
    typescriptFunction = { fg = orange.orange },
    typescriptMethod = { fg = orange.orange },
    typescriptCall = { fg = orange.orange },
    typescriptDecorator = { fg = orange.magenta },
    typescriptReserved = { fg = orange.magenta },
    typescriptStatement = { fg = orange.magenta },
    typescriptKeyword = { fg = orange.magenta },
    typescriptOperator = { fg = orange.orange },
    typescriptArrowFunc = { fg = orange.orange },
  })

  set_many({
    tsxTagName = { fg = orange.magenta },
    tsxComponentName = { fg = orange.orange, bold = true },
    tsxCloseString = { fg = orange.gray },
    tsxAttrib = { fg = orange.orange, italic = true },
    tsxTag = { fg = orange.magenta },
    tsxCloseTag = { fg = orange.magenta },
    tsxEqual = { fg = orange.magenta },
    tsxEscapedContent = { fg = orange.yellow },
    tsxBraces = { fg = orange.white },
  })

  set_many({
    htmlTag = { fg = orange.fg },
    htmlEndTag = { fg = orange.fg },
    htmlTagName = { fg = orange.magenta },
    htmlSpecialTagName = { fg = orange.magenta },
    htmlArg = { fg = orange.orange, italic = true },
    htmlLink = { fg = orange.orange, underline = true },
    htmlString = { fg = orange.yellow },
  })

  set_many({
    cssTagName = { fg = orange.magenta },
    cssClassName = { fg = orange.orange },
    cssIdentifier = { fg = orange.orange },
    cssSelectorOp = { fg = orange.magenta },
    cssProp = { fg = orange.orange },
    cssAttr = { fg = orange.orange },
    cssUnitDecorators = { fg = orange.magenta },
    cssColor = { fg = orange.orange },
  })

  set_many({
    javaScriptReserved = { fg = orange.magenta },
    javaScriptConditional = { fg = orange.magenta },
    javaScriptRepeat = { fg = orange.magenta },
    javaScriptOperator = { fg = orange.magenta },
    javaScriptFunction = { fg = orange.orange },
    javaScriptIdentifier = { fg = orange.orange },
    javaScriptGlobal = { fg = orange.orange },
    javaScriptMember = { fg = orange.orange },
    javaScriptBraces = { fg = orange.fg },
    javaScriptParens = { fg = orange.fg },
  })

  set_many({
    luaFunctionCall = { fg = orange.orange },
    luaTable = { fg = orange.yellow },
    pythonBuiltin = { fg = orange.orange },
    pythonStatement = { fg = orange.magenta },
    jsonKeyword = { fg = orange.magenta },
    yamlPlainScalar = { fg = orange.yellow },
  })
end

return theme
