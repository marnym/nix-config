local wezterm = require "wezterm"

local config = {}

local success, stdout, _ = wezterm.run_child_process { 'uname' }

if success and stdout:match('Darwin') then
    wezterm.log_info("Running on macOS")
    config.font = wezterm.font_with_fallback({
        "SF Mono",
        "JetBrains Mono Nerd Font",
        "JetBrains Mono",
    })
else
    wezterm.log_info("Running on Linux")
    config.font = wezterm.font_with_fallback({
        "IBM Plex Mono",
        "BlexMono Nerd Font",
        "JetBrains Mono Nerd Font",
        "JetBrains Mono",
    })
end

config.font_size = 14.0
config.color_scheme = "Tokyo Night"
config.enable_tab_bar = false

return config
