local wezterm = require "wezterm"
local kanagawa = require "kanagawa"

local success, stdout, _ = wezterm.run_child_process { 'uname' }

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.force_reverse_video_cursor = kanagawa.force_reverse_video_cursor
config.colors = kanagawa.colors
config.default_cursor_style = 'BlinkingBar'

if success and stdout:match('Darwin') then
    wezterm.log_info("Running on macOS")

    config.font = wezterm.font("JetBrainsMono Nerd Font")
    config.font_size = 14.0

    config.keys = {
        { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1b\x62" } },
        { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1b\x66" } },
    }
else
    wezterm.log_info("Running on Linux")

    config.font = wezterm.font("JetBrains Mono Nerd Font")
    config.font_size = 16.0

    config.keys = {
        { key = "LeftArrow",  mods = "CTRL", action = wezterm.action { SendString = "\x1b\x62" } },
        { key = "RightArrow", mods = "CTRL", action = wezterm.action { SendString = "\x1b\x66" } },
    }
end


config.enable_tab_bar = false

return config
