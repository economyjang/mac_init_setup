local term = require("wezterm")

local config = term.config_builder()

config.automatically_reload_config = true

-- Tab / Window
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- 가독성 우선
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.macos_window_background_blur = 0

-- Cursor
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 600

-- Font
config.font = term.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "NanumGothicCoding",
  "Nanum Gothic Coding",
  "Apple SD Gothic Neo",
})

config.font_size = 14
config.line_height = 1.2
config.cell_width = 1.0

-- Color Scheme
config.color_scheme = "GitHub Dark"

-- Window Padding
config.window_padding = {
  left = 16,
  right = 16,
  top = 10,
  bottom = 10,
}

-- 긴 Claude Code 응답 대비
config.scrollback_lines = 20000

-- Claude Code 같은 TUI에서 Shift + Drag로 터미널 선택 가능
config.bypass_mouse_reporting_modifiers = "SHIFT"

config.keys = {
  {
    key = "]",
    mods = "CTRL",
    action = term.action.SplitHorizontal,
  },
  {
    key = "[",
    mods = "CTRL",
    action = term.action.SplitVertical,
  },
  {
    key = "s",
    mods = "CTRL",
    action = term.action.PaneSelect,
  },
  {
    key = "q",
    mods = "CTRL",
    action = term.action.CloseCurrentPane({ confirm = true }),
  },

  -- Pane resize
  {
    key = "H",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Left", 1 }),
  },
  {
    key = "J",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Down", 1 }),
  },
  {
    key = "K",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Up", 1 }),
  },
  {
    key = "L",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Right", 1 }),
  },

  -- Copy / Paste
  {
    key = "c",
    mods = "CMD",
    action = term.action.CopyTo("Clipboard"),
  },
  {
    key = "v",
    mods = "CMD",
    action = term.action.PasteFrom("Clipboard"),
  },

  -- Copy Mode
  {
    key = "x",
    mods = "CMD|SHIFT",
    action = term.action.ActivateCopyMode,
  },
}

return config
