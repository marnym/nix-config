local function yaml_schema()
	local schema_name = require("yaml-companion").get_buf_schema(0).result[1].name
	if schema_name ~= "none" then
		return schema_name
	end
	return ""
end

require "lualine".setup {
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		section_separators = { "", "" },
		component_separators = { "", "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{ "filename", path = 1 }
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			yaml_schema,
			"filetype",
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
