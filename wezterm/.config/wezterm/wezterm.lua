local wezterm = require "wezterm"

local success, stdout, _ = wezterm.run_child_process { 'uname' }

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

if success and stdout:match('Darwin') then
    wezterm.log_info("Running on macOS")
    config.font = wezterm.font_with_fallback({
        "SF Mono",
        "JetBrains Mono Nerd Font",
        "JetBrains Mono",
    })
    config.font_size = 14.0
    config.color_scheme = "tokyonight-storm"
else
    wezterm.log_info("Running on Linux")
    config.font = wezterm.font_with_fallback({
        "IBM Plex Mono",
        "BlexMono Nerd Font",
        "JetBrains Mono Nerd Font",
        "JetBrains Mono",
    })
    config.font_size = 16.0
    config.color_scheme = "Tokyo Night Storm"
end


config.enable_tab_bar = false

return config
