local function toggle_move()
    if vim.v.count > 0 then
        require "harpoon.ui".nav_file(vim.v.count)
    else
        require "harpoon.mark".toggle_file()
    end
end

local M = {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "gh",
            toggle_move,
            desc = "Mark file"
        },
        {
            "gH",
            function() require "harpoon.ui".toggle_quick_menu() end,
            desc = "Toggle menu"
        },
    }
}

return M
