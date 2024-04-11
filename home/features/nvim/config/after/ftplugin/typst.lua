local program = "zathura"
if vim.uv.os_uname().sysname == "Darwin" then
    program = "open"
end

local function open_result()
    local pdf = string.format("%s.pdf", vim.fn.expand("%:p:r"))
    vim.system({ program, pdf }, { detach = true })
end

vim.keymap.set("n", "<leader>z", open_result, { buffer = true, noremap = true, silent = true })

local output = ""

---@param err string
---@param data string
local function on_err(err, data)
    assert(not err, err)

    output = output .. data
    local lines = vim.split(output, "\n")
    for _, line in pairs(lines) do
        local match = line:match(".*(compiled.*)")
        if match then
            vim.schedule(function() vim.notify("typst: " .. match) end)
            output = ""
        end
    end
end

if vim.fn.expand("%:t") == "main.typ" then
    vim.system({ "typst", "watch", "main.typ" }, { text = true, stderr = on_err })
end
