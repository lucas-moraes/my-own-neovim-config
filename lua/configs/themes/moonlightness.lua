---@diagnostic disable: undefined-global

local theme = {}

function theme.setup()
  vim.o.termguicolors = true
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"

  local moon = {
    bg = "#1e2030",
    fg = "#c8d3f5",
    comment = "#7a88cf",
    red = "#ff757f",
    orange = "#ff966c",
    yellow = "#ffc777",
    green = "#c3e88d",
    cyan = "#86e1fc",
    blue = "#82aaff",
    magenta = "#c099ff",
    black = "#1b1d2b",
    white = "#c8d3f5",
    gray = "#444a73",
  }

  local function set_many(defs)
    for group, opts in pairs(defs) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

  vim.api.nvim_set_hl(0, "Normal", { bg = moon.bg, fg = moon.fg })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = moon.bg })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = moon.bg, bg = moon.bg })

  vim.o.list = true
  vim.o.listchars = "space:·,eol:↴,tab:│ ,trail:·,extends:>,precedes:<,conceal:┊,nbsp:+"
  vim.api.nvim_set_hl(0, "Whitespace", { fg = moon.black })
  vim.api.nvim_set_hl(0, "NonText", { fg = moon.gray })

  vim.api.nvim_set_hl(0, "CursorLine", { bg = moon.black })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = moon.black })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = moon.black })
  vim.api.nvim_set_hl(0, "LineNr", { fg = moon.gray })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = moon.cyan })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = moon.white, bg = moon.gray })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = moon.gray, bg = moon.black })
  vim.api.nvim_set_hl(0, "TabLine", { fg = moon.white, bg = moon.black })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = moon.black })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = moon.white, bg = moon.gray })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = moon.gray })

  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = moon.blue, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = moon.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = moon.white })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = moon.white })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = moon.white })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = moon.green })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = moon.yellow })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = moon.red })
  vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = moon.red })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = moon.gray })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = moon.cyan })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = moon.white, bg = "none" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = moon.black })
  vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = moon.cyan })

  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = moon.gray, italic = true })

  set_many({
    Keyword = { fg = moon.magenta },
    Function = { fg = moon.cyan },
    Parameter = { fg = moon.white },
    String = { fg = moon.green },
    Type = { fg = moon.yellow },
    Number = { fg = moon.orange },
    Boolean = { fg = moon.orange },
    Operator = { fg = moon.blue },
    Comment = { fg = moon.comment, italic = true },
    Constant = { fg = moon.cyan },
    PreProc = { fg = moon.yellow },
    Error = { fg = moon.bg, bg = moon.red, bold = true },
    Property = { fg = moon.white },
    Atributes = { fg = moon.white },
    Tag = { fg = moon.magenta },
    Identifier = { fg = moon.blue },
    Delimiter = { fg = moon.gray },
    PunctuationBracket = { fg = moon.gray },
    Special = { fg = moon.cyan },
  })



  set_many({
    luaFunctionCall = { fg = moon.cyan },
    luaTable = { fg = moon.green },
    pythonBuiltin = { fg = moon.cyan },
    pythonStatement = { fg = moon.magenta },
    pythonFunction = { fg = moon.cyan },
    pythonMethod = { fg = moon.cyan },
    pythonClass = { fg = moon.cyan, bold = true },
    pythonDecorator = { fg = moon.orange },
    pythonParameters = { fg = moon.white },
    pythonSelf = { fg = moon.magenta, italic = true },
    pythonReturnAnnotation = { fg = moon.cyan, italic = true },
    pythonDocstring = { fg = moon.comment, italic = true },
  })
end

return theme
