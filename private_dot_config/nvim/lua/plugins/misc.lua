local function misc_plugins(use)
	-- profile vim startup time
	use("dstein64/vim-startuptime")
	-- optimize the startup time
	use("lewis6991/impatient.nvim")

	-- defer the evaluation after mkdp.nvim installed
	local mkdp_after_install = function()
		return vim.fn["mkdp#util#install"]()
	end
	-- markdown preview rendering in the browser
	use({ "iamcco/markdown-preview.nvim", run = mkdp_after_install, ft = { "markdown" } })

	-- vim syntax package
	use("sheerun/vim-polyglot")
end
return misc_plugins
