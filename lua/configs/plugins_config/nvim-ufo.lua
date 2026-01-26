local status, ufo = pcall(require, "ufo")
if not status then
  return
end

local handler = function(virt_text, lnum, end_lnum, width, truncate)
  local new_virt_text = {}
  local suffix = "  󰁂 "
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local cur_width = 0

  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)

    if target_width > cur_width + chunk_width then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - cur_width)
      table.insert(new_virt_text, { chunk_text, chunk[2] })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)

      if cur_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
      end

      break
    end

    cur_width = cur_width + chunk_width
  end

  table.insert(new_virt_text, { suffix, "MoreMsg" })
  return new_virt_text
end

ufo.setup({
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
  fold_virt_text_handler = handler,
})
