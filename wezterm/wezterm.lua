local wezterm = require "wezterm"

local success, stdout, _ = wezterm.run_child_process { 'uname' }

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
    "JetBrains Mono Nerd Font",
    "JetBrains Mono",
})

if success and stdout:match('Darwin') then
    wezterm.log_info("Running on macOS")
    config.font_size = 14.0
    config.color_scheme = "tokyonight-storm"
else
    wezterm.log_info("Running on Linux")
    config.font_size = 16.0
    config.color_scheme = "Tokyo Night Storm"
end


config.enable_tab_bar = false

return config
