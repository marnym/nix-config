local function lsps()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	-- return empty string if empty
	if #client_names == 0 then
		return ""
	end

	return " LSP: " .. table.concat(client_names, ", ")
end

local function yaml_schema()
	if vim.bo.filetype ~= "yaml" then
		return ""
	end

	local schema_name = require("yaml-companion").get_buf_schema(0).result[1].name
	if schema_name ~= "none" then
		return schema_name
	end
	return ""
end

local M = {
	"hoob3rt/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			icons_enabled = true,
			theme = "kanagawa",
			section_separators = { left = "", right = "" },
			component_separators = "|",
			disabled_filetypes = {},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{
					"filetype",
					icon_only = true,
				},
				{ "filename", path = 1 }
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
				yaml_schema,
				lsps,
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	}
}

return M
