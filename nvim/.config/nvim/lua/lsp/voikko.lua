local configs = require "lspconfig.configs"
local util = require 'lspconfig.util'

local language_id_mapping = {
	bib = 'bibtex',
	plaintex = 'tex',
	tex = 'latex',
}

local bin_name = 'voikko-ls'

configs.voikkols = {
	default_config = {
		cmd                 = { "/home/markus/dev/masnen/voikko/voikkols/start-voikko.sh" },
		filetypes           = { 'bib', 'plaintex', 'tex', 'text' },
		root_dir            = util.root_pattern('voikko'),
		single_file_support = true,
		get_language_id     = function(_, filetype)
			local language_id = language_id_mapping[filetype]
			if language_id then
				return language_id
			else
				return filetype
			end
		end,
		docs                = {
			description = "test"
		}
	}
}
