local wezterm = require "wezterm"

return {
    font = wezterm.font_with_fallback {
        'SF Mono',
        'JetBrainsMono Nerd Font',
    },
    font_size = 13.0,
    color_scheme = "Catppuccin Mocha",
}
