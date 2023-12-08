local wezterm = require "wezterm"
local gruvbox_material = require "gruvbox-material"

local success, stdout, _ = wezterm.run_child_process { 'uname' }

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.enable_wayland = false
config.force_reverse_video_cursor = true
config.colors = gruvbox_material.colors
config.default_cursor_style = 'BlinkingBar'

config.font = wezterm.font("BlexMono Nerd Font")
config.font_size = 14.0

if success and stdout:match('Darwin') then
    wezterm.log_info("Running on macOS")

    config.keys = {
        { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1b\x62" } },
        { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1b\x66" } },
    }
else
    wezterm.log_info("Running on Linux")

    config.keys = {
        { key = "LeftArrow",  mods = "CTRL", action = wezterm.action { SendString = "\x1b\x62" } },
        { key = "RightArrow", mods = "CTRL", action = wezterm.action { SendString = "\x1b\x66" } },
    }
end


config.enable_tab_bar = false

return config
