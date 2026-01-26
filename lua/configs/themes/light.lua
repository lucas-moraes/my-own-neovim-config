---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "light"

  local dracula_light = {
    bg = "#fbf9f1",
    fg = "#282a36",
    comment = "#8a94b4",
    red = "#ff5555",
    orange = "#c27c34",
    yellow = "#b59b00",
    green = "#2d984d",
    cyan = "#008197",
    blue = "#4d5b7a",
    magenta = "#7d47c2",
    pink = "#c53b7c",
    black = "#d0d0d0",
    white = "#282a36",
    gray = "#e8e8e8",
    light_gray = "#f0f0f0",
  }

  local function set_many(defs)
    for group, opts in pairs(defs) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  vim.api.nvim_set_hl(0, "Normal", { bg = dracula_light.bg, fg = dracula_light.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = dracula_light.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = dracula_light.bg, bg = dracula_light.bg })

  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
  vim.api.nvim_set_hl(0, "Whitespace", { fg = dracula_light.black })
  vim.api.nvim_set_hl(0, "NonText", { fg = dracula_light.black })

  vim.api.nvim_set_hl(0, "Cursor", { fg = dracula_light.black, bg = dracula_light.pink })
  vim.api.nvim_set_hl(0, "CursorIM", { fg = dracula_light.black, bg = dracula_light.pink })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = dracula_light.light_gray })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = dracula_light.light_gray })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = dracula_light.light_gray })
  vim.api.nvim_set_hl(0, "LineNr", { fg = dracula_light.comment })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dracula_light.orange })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = dracula_light.fg, bg = dracula_light.gray, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = dracula_light.comment, bg = dracula_light.light_gray })
  vim.api.nvim_set_hl(0, "TabLine", { fg = dracula_light.fg, bg = dracula_light.gray })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = dracula_light.gray })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = dracula_light.bg, bg = dracula_light.pink, bold = true })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = dracula_light.black })
  vim.api.nvim_set_hl(0, "Visual", { bg = dracula_light.gray })

  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = dracula_light.magenta, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = dracula_light.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = dracula_light.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = dracula_light.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = dracula_light.fg })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = dracula_light.green })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = dracula_light.orange })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = dracula_light.red })
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = dracula_light.red })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = dracula_light.black })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = dracula_light.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = dracula_light.fg, bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = dracula_light.light_gray })
  vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = dracula_light.pink })

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = dracula_light.comment, italic = true })

  set_many({
    Keyword = { fg = dracula_light.pink },
    Function = { fg = dracula_light.green },
    Parameter = { fg = dracula_light.fg },
    String = { fg = dracula_light.yellow },
    Type = { fg = dracula_light.cyan },
    Number = { fg = dracula_light.orange },
    Boolean = { fg = dracula_light.orange },
    Operator = { fg = dracula_light.magenta },
    Comment = { fg = dracula_light.comment, italic = true },
    Constant = { fg = dracula_light.cyan },
    PreProc = { fg = dracula_light.pink },
    Error = { fg = dracula_light.bg, bg = dracula_light.red, bold = true },
    Property = { fg = dracula_light.fg },
    Atributes = { fg = dracula_light.fg },
    Tag = { fg = dracula_light.magenta },
    Identifier = { fg = dracula_light.magenta },
    Delimiter = { fg = dracula_light.blue },
    PunctuationBracket = { fg = dracula_light.blue },
    Special = { fg = dracula_light.cyan },
  })

  set_many({
    typescriptTypeReference = { fg = dracula_light.cyan, italic = true },
    typescriptTypeParameter = { fg = dracula_light.orange, italic = true },
    typescriptInterfaceName = { fg = dracula_light.cyan, bold = true },
    typescriptEnumName = { fg = dracula_light.cyan },
    typescriptIdentifier = { fg = dracula_light.cyan },
    typescriptVariable = { fg = dracula_light.green },
    typescriptProp = { fg = dracula_light.yellow },
    typescriptFunction = { fg = dracula_light.green },
    typescriptMethod = { fg = dracula_light.green },
    typescriptCall = { fg = dracula_light.green },
    typescriptDecorator = { fg = dracula_light.orange },
    typescriptReserved = { fg = dracula_light.pink },
    typescriptStatement = { fg = dracula_light.pink },
    typescriptKeyword = { fg = dracula_light.pink },
    typescriptOperator = { fg = dracula_light.magenta },
    typescriptArrowFunc = { fg = dracula_light.magenta },
  })

  set_many({
    tsxTagName = { fg = dracula_light.pink },
    tsxComponentName = { fg = dracula_light.magenta, bold = true },
    tsxCloseString = { fg = dracula_light.black },
    tsxAttrib = { fg = dracula_light.green, italic = true },
    tsxTag = { fg = dracula_light.magenta },
    tsxCloseTag = { fg = dracula_light.magenta },
    tsxEqual = { fg = dracula_light.pink },
    tsxEscapedContent = { fg = dracula_light.yellow },
    tsxBraces = { fg = dracula_light.white },
  })

  set_many({
    htmlTag = { fg = dracula_light.fg },
    htmlEndTag = { fg = dracula_light.fg },
    htmlTagName = { fg = dracula_light.pink },
    htmlSpecialTagName = { fg = dracula_light.pink },
    htmlArg = { fg = dracula_light.green, italic = true },
    htmlLink = { fg = dracula_light.cyan, underline = true },
    htmlString = { fg = dracula_light.yellow },
  })

  set_many({
    cssTagName = { fg = dracula_light.pink },
    cssClassName = { fg = dracula_light.green },
    cssIdentifier = { fg = dracula_light.orange },
    cssSelectorOp = { fg = dracula_light.pink },
    cssProp = { fg = dracula_light.cyan },
    cssAttr = { fg = dracula_light.orange },
    cssUnitDecorators = { fg = dracula_light.pink },
    cssColor = { fg = dracula_light.magenta },
  })

  set_many({
    javaScriptReserved = { fg = dracula_light.pink },
    javaScriptConditional = { fg = dracula_light.pink },
    javaScriptRepeat = { fg = dracula_light.pink },
    javaScriptOperator = { fg = dracula_light.pink },
    javaScriptFunction = { fg = dracula_light.green },
    javaScriptIdentifier = { fg = dracula_light.magenta },
    javaScriptGlobal = { fg = dracula_light.cyan },
    javaScriptMember = { fg = dracula_light.orange },
    javaScriptBraces = { fg = dracula_light.fg },
    javaScriptParens = { fg = dracula_light.fg },
  })

  set_many({
    luaFunctionCall = { fg = dracula_light.green },
    luaTable = { fg = dracula_light.yellow },
    pythonBuiltin = { fg = dracula_light.cyan },
    pythonStatement = { fg = dracula_light.pink },
    jsonKeyword = { fg = dracula_light.pink },
    yamlPlainScalar = { fg = dracula_light.yellow },
  })
end

return theme
