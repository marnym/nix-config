local opts = { noremap = true, silent = true }

local function vim_cmd(cmd)
    return function()
        return vim.cmd(cmd)
    end
end

-- move by line
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

-- Use alt + hjkl to resize windows
vim.keymap.set("n", "<M-j>", vim_cmd("resize -2"), opts)
vim.keymap.set("n", "<M-k>", vim_cmd("resize +2"), opts)
vim.keymap.set("n", "<M-h>", vim_cmd("vertical resize -2"), opts)
vim.keymap.set("n", "<M-l>", vim_cmd("vertical resize +2"), opts)

vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("i", "kj", "<Esc>", opts)

-- SHIFT-TAB to de-tab
vim.keymap.set("i", "<S-TAB>", "<C-d>", opts)

-- Better tabbing
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", function()
    if vim.bo.ft == "starter" then
        require("mini.starter").update_current_item("next")
    else
        vim.cmd("wincmd j")
    end
end, opts)
vim.keymap.set("n", "<C-k>", function()
    if vim.bo.ft == "starter" then
        require("mini.starter").update_current_item("prev")
    else
        vim.cmd("wincmd k")
    end
    -- add expr = true to opts
end, opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-s>", "a<C-X><C-S>", opts)

-- bufdelete
vim.keymap.set("n", "<leader>bd", vim_cmd("bwipeout!"), opts)

-- exit terminal mode
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", opts)

-- Plugins
vim.keymap.set("n", "<leader>tb", vim_cmd("Gitsigns toggle_current_line_blame"))
vim.keymap.set("n", "<leader>th", vim_cmd("Gitsigns preview_hunk"))
vim.keymap.set("n", "<leader>tn", vim_cmd("Gitsigns next_hunk"))
vim.keymap.set("n", "<leader>tp", vim_cmd("Gitsigns prev_hunk"))
vim.keymap.set("n", "<leader>pr", function()
    vim.cmd("ProjectRoot")
    vim.print("Set project root to " .. vim.fn.getcwd())
end)
