-- See <https://github.com/lervag/vimtex>
--

vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

vim.g.vimtex_compiler_method = "tectonic"

local vimtex_grp = vim.api.nvim_create_augroup("vimtex", {})
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = { "tex" },
	callback = function(args)
		local _ = args
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "vimtex#fold#level(v:lnum)"
		vim.wo.foldtext = "vimtex#fold#text()"
	end,
	group = vimtex_grp,
	desc = "use foldexpr provided by VimTex for LaTeX filetype",
})