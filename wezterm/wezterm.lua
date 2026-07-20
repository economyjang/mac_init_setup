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

-- Font: D2Coding 한 family로 라틴+한글+Nerd 아이콘 통일 (폰트 폭 불일치로 인한 깨짐 방지)
config.font = term.font_with_fallback({
  {
    family = "D2CodingLigature Nerd Font",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- 리거처 off
  },
  "Apple SD Gothic Neo", -- 최후 fallback (희귀 글리프)
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

-- macOS: Option(OPT) 누를 때 특수문자 조합을 끄고 Alt 모디파이어로 취급
-- (한글 IME는 별개라 영향 없음. OPT 단축키가 동작하도록)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

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

  -- Pane resize (macOS에서 Option+Shift 없이 눌리도록 소문자 키 사용)
  {
    key = "h",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Left", 1 }),
  },
  {
    key = "j",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Down", 1 }),
  },
  {
    key = "k",
    mods = "OPT",
    action = term.action.AdjustPaneSize({ "Up", 1 }),
  },
  {
    key = "l",
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
