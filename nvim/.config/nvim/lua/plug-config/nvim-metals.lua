local M = {}

function M.setup()
	local metals_config = require "metals".bare_config {}

	metals_config.settings = {
		showImplicitArguments = true,
		excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	}

	local nvim_metals_group = vim.api.nvim_create_augroup("NvimMetals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt" },
		callback = function()
			require "metals".initialize_or_attach(metals_config)
		end,
		group = nvim_metals_group,
	})
end

return M
