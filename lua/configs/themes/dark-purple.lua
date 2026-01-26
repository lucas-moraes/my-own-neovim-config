---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"

  local purple = {
    bg = "#1e1b29",
    fg = "#cfa9f7",
    comment = "#8b5fbf",
    red = "#e0115f",
    orange = "#a037bf",
    yellow = "#e6ccff",
    green = "#cfa9f7",
    cyan = "#bf80ff",
    blue = "#bf80ff",
    magenta = "#a37bff",
    black = "#2a2340",
    white = "#d1c0f0",
    gray = "#3a2d4a",
  }

  local function set_many(defs)
    for group, opts in pairs(defs) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  vim.api.nvim_set_hl(0, "Normal", { bg = purple.bg, fg = purple.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = purple.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = purple.bg, bg = purple.bg })

  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"

  vim.api.nvim_set_hl(0, "Whitespace", { fg = purple.gray })
  vim.api.nvim_set_hl(0, "NonText", { fg = purple.gray })

  vim.api.nvim_set_hl(0, "CursorLine", { bg = purple.black })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = purple.gray })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = purple.gray })
  vim.api.nvim_set_hl(0, "LineNr", { fg = purple.comment })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = purple.fg })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = purple.cyan, bg = purple.gray })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = purple.cyan, bg = purple.black })
  vim.api.nvim_set_hl(0, "TabLine", { fg = purple.white, bg = purple.black })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = purple.black })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = purple.white, bg = purple.gray })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = purple.cyan, bg = "none" })

  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = purple.fg, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = purple.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = purple.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = purple.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = purple.white })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = purple.comment })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = purple.comment })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = purple.comment })
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = purple.orange })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = purple.gray })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = purple.fg })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = purple.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = purple.gray })
  vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = purple.fg, bg = "none" })

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = purple.comment, italic = true })

  set_many({
    Keyword = { fg = purple.magenta },
    Function = { fg = purple.cyan },
    Parameter = { fg = purple.white },
    String = { fg = purple.yellow },
    Type = { fg = purple.fg },
    Number = { fg = purple.orange },
    Boolean = { fg = purple.orange },
    Operator = { fg = purple.cyan },
    Comment = { fg = purple.comment, italic = true },
    Constant = { fg = purple.fg },
    PreProc = { fg = purple.magenta },
    Error = { fg = purple.red, bold = true, bg = "#7a2973" },
    Property = { fg = purple.magenta },
    Atributes = { fg = purple.magenta },
    Tag = { fg = purple.orange },
    Identifier = { fg = purple.cyan },
    Delimiter = { fg = purple.cyan },
    PunctuationBracket = { fg = purple.magenta },
    Special = { fg = purple.cyan },
  })

  set_many({
    typescriptTypeReference = { fg = purple.fg, italic = true },
    typescriptTypeParameter = { fg = purple.orange, italic = true },
    typescriptInterfaceName = { fg = purple.fg, bold = true },
    typescriptEnumName = { fg = purple.fg },
    typescriptIdentifier = { fg = purple.fg },
    typescriptVariable = { fg = purple.cyan },
    typescriptProp = { fg = purple.yellow },
    typescriptFunction = { fg = purple.cyan },
    typescriptMethod = { fg = purple.cyan },
    typescriptCall = { fg = purple.cyan },
    typescriptDecorator = { fg = purple.orange },
    typescriptReserved = { fg = purple.magenta },
    typescriptStatement = { fg = purple.magenta },
    typescriptKeyword = { fg = purple.magenta },
    typescriptOperator = { fg = purple.cyan },
    typescriptArrowFunc = { fg = purple.cyan },
  })

  set_many({
    tsxTagName = { fg = purple.magenta },
    tsxComponentName = { fg = purple.cyan, bold = true },
    tsxCloseString = { fg = purple.gray },
    tsxAttrib = { fg = purple.magenta, italic = true },
    tsxTag = { fg = purple.magenta },
    tsxCloseTag = { fg = purple.magenta },
    tsxEqual = { fg = purple.magenta },
    tsxEscapedContent = { fg = purple.yellow },
    tsxBraces = { fg = purple.white },
  })

  set_many({
    htmlTag = { fg = purple.fg },
    htmlEndTag = { fg = purple.fg },
    htmlTagName = { fg = purple.magenta },
    htmlSpecialTagName = { fg = purple.magenta },
    htmlArg = { fg = purple.magenta, italic = true },
    htmlLink = { fg = purple.cyan, underline = true },
    htmlString = { fg = purple.yellow },
  })

  set_many({
    cssTagName = { fg = purple.magenta },
    cssClassName = { fg = purple.cyan },
    cssIdentifier = { fg = purple.orange },
    cssSelectorOp = { fg = purple.magenta },
    cssProp = { fg = purple.cyan },
    cssAttr = { fg = purple.orange },
    cssUnitDecorators = { fg = purple.magenta },
    cssColor = { fg = purple.cyan },
  })

  set_many({
    javaScriptReserved = { fg = purple.magenta },
    javaScriptConditional = { fg = purple.magenta },
    javaScriptRepeat = { fg = purple.magenta },
    javaScriptOperator = { fg = purple.magenta },
    javaScriptFunction = { fg = purple.cyan },
    javaScriptIdentifier = { fg = purple.cyan },
    javaScriptGlobal = { fg = purple.fg },
    javaScriptMember = { fg = purple.orange },
    javaScriptBraces = { fg = purple.fg },
    javaScriptParens = { fg = purple.fg },
  })

  set_many({
    luaFunctionCall = { fg = purple.cyan },
    luaTable = { fg = purple.yellow },
    pythonBuiltin = { fg = purple.cyan },
    pythonStatement = { fg = purple.magenta },
    jsonKeyword = { fg = purple.magenta },
    yamlPlainScalar = { fg = purple.yellow },
  })
end

return theme
