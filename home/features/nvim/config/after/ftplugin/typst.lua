--- @class ErrorInfo
--- @field message string
--- @field compilation_error_line integer|nil
--- @field error_line_seen boolean
--- @field last_empty_line integer

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


-- @class ErrorInfo
local ErrorInfo = {
    message = "",
    compilation_error_line = nil,
    error_line_seen = false,
    last_empty_line = -1
}
local error_info_mt = {
    __index = ErrorInfo
}

--- @return boolean
function ErrorInfo:should_notify()
    return self.compilation_error_line ~= nil and self.error_line_seen and
        self.last_empty_line > self.compilation_error_line
end

--- @param lines table[string]
function ErrorInfo:notify(lines)
    vim.schedule(function()
        vim.notify(self.message ..
            table.concat(
                vim.list_slice(lines, self.compilation_error_line + 1, self.last_empty_line - 1), "\n"))
    end)
end

---@param err string
---@param data string
local function on_err(err, data)
    assert(not err, err)

    output = output .. data

    local error_info = setmetatable({}, error_info_mt)

    local lines = vim.split(output, "\n")
    for i, line in ipairs(lines) do
        local compiled_match = line:match("compiled.*")
        if compiled_match then
            if compiled_match:match("successfully") then
                vim.schedule(function() vim.notify("typst: " .. compiled_match) end)
                output = ""
                break
            else
                error_info.compilation_error_line = i
                error_info.message = "typst: " .. compiled_match
            end
        end

        if error_info.compilation_error_line and not error_info.error_line_seen and vim.startswith(line, "error:") then
            error_info.error_line_seen = true
        end

        if error_info.error_line_seen and line == "" then
            error_info.last_empty_line = i
        end
    end

    if error_info:should_notify() then
        error_info:notify(lines)
        output = ""
    end
end

if vim.fn.expand("%:t") == "main.typ" then
    vim.system({ "typst", "watch", "main.typ" }, { text = true, stderr = on_err })
end
