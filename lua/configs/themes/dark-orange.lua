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
    luaFunctionCall = { fg = orange.orange },
    luaTable = { fg = orange.yellow },
    pythonBuiltin = { fg = orange.orange },
    pythonStatement = { fg = orange.magenta },
    pythonFunction = { fg = orange.orange },
    pythonMethod = { fg = orange.orange },
    pythonClass = { fg = orange.fg, bold = true },
    pythonDecorator = { fg = orange.magenta },
    pythonParameters = { fg = orange.fg },
    pythonSelf = { fg = orange.magenta, italic = true },
    pythonReturnAnnotation = { fg = orange.orange, italic = true },
    pythonDocstring = { fg = orange.comment, italic = true },
  })
end

return theme
