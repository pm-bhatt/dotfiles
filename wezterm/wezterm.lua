local wezterm = require("wezterm")
config = wezterm.config_builder()
wezterm.log_error('MY WEZTERM CONFIG IS LOADING!')


config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE", -- disable the
  default_cursor_style = "BlinkingBar",
  color_scheme = "Nord (Gogh)",
  font = wezterm.font("JetBrains Mono", {weight = "Bold"}),
  font_size = 18,
}
return config