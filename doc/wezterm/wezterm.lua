local wezterm = require("wezterm")
local act = wezterm.action

-- Garante que o título da janela fique sempre vazio
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config, hover, max_width)
  return ""
end)

return {
  font = wezterm.font_with_fallback({ "Fira Code", "JetBrains Mono" }),
  font_size = 13.0,
  window_background_opacity = 0.9,

  harfbuzz_features = { "calt=1", "clig=1", "liga=1" },

  color_scheme = "Dracula",

  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",

  default_prog = { '/bin/zsh', '--login' },

  keys = {
    -- fullscreen toggle
    { key="F", mods="CTRL|SHIFT", action=act.ToggleFullScreen },
    -- zoom na pane atual
    { key="Z", mods="CTRL|SHIFT", action=act.TogglePaneZoomState },
  },
}
