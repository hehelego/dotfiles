-- See <https://github.com/lervag/vimtex>

-- do not open quickfix window automatically
vim.g.vimtex_quickfix_mode = 0

-- allow overwriting the default tex filetype syntax&highlight
vim.g.tex_flavor = "latex"

-- allow vimtex symbol concealing
vim.g.tex_conceal = "abdgm"

-- doc viewer: zathura
vim.g.vimtex_view_method = "zathura"

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
