local function load_env_file()
  local env_path = vim.fn.stdpath("config") .. "/.env"
  local file = io.open(env_path, "r")
  if not file then
    return
  end
  for line in file:lines() do
    local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
    if key and vim.env[key] == nil then
      vim.env[key] = value
    end
  end
  file:close()
end

local ok, minuet = pcall(require, "minuet")
if not ok then
  return
end

load_env_file()

if vim.env.DEEPINFRA_API_KEY == nil or vim.env.DEEPINFRA_API_KEY == "" then
  vim.notify(
    "Minuet: DEEPINFRA_API_KEY ausente. Defina a env var para ativar o code completion.",
    vim.log.levels.WARN
  )
end

minuet.setup({
  provider = "openai_fim_compatible",
  n_completions = 1,
  context_window = 409600,
  throttle = 1000,
  debounce = 400,
  request_timeout = 3,
  notify = "warn",
  virtualtext = {
    auto_trigger_ft = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "tsx",
      "jsx",
      "lua",
      "css",
      "html",
      "json",
      "yaml",
      "markdown",
    },
    keymap = {
      accept = "<M-Enter>",
      accept_line = "<M-l>",
      accept_n_lines = "<M-z>",
      dismiss = "<C-]>",
      next = "<M-]>",
      prev = "<M-[>",
    },
    show_on_completion_menu = false,
  },
  provider_options = {
    openai_fim_compatible = {
      model = "deepseek-ai/DeepSeek-V4-Flash",
      end_point = "https://api.deepinfra.com/v1/inference",
      api_key = "DEEPINFRA_API_KEY",
      name = "DeepInfra",
      stream = true,
      template = {
        prompt = function(before, _)
          local utils = require("minuet.utils")
          local language = utils.add_language_comment()
          local tab = utils.add_tab_comment()
          return language .. "\n" .. tab .. "\n" .. before
        end,
        suffix = function(_, after)
          return after
        end,
      },
      transform = {
        function(args)
          args.end_point = args.end_point .. "/" .. args.body.model
          args.body.model = nil
          args.body.input = args.body.prompt
          args.body.prompt = nil
          args.body.stop = { "\n}" }
          args.body.prompt_cache_key = vim.fn.sha256(
            vim.api.nvim_buf_get_name(0) .. ":" .. vim.api.nvim_buf_get_changedtick(0)
          )
          return args
        end,
      },
      optional = {
        max_tokens = 256,
      },
      get_text_fn = {
        no_stream = function(json)
          return json.results and json.results[1] and json.results[1].generated_text
        end,
        stream = function(json)
          return json.token and json.token.text or ""
        end,
      },
    },
  },
})
