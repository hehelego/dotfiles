-- See <https://github.com/folke/todo-comments.nvim>

-- list of keywords
local _ = {
	"TODO",
	"NOTE",
	"INFO",
	"BUG",
	"FIXME",
	"FIXIT",
	"HACK",
	"WARN",
	"ISSUE",
	"PERF",
}
require("todo-comments").setup({
	signs = true, -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- keywords recognized as todo comments
	keywords = {
		TODO = { icon = " ", color = "default", alt = { "TODO" } },
		NOTE = { icon = " ", color = "info", alt = { "INFO", "NOTE" } },
		BUG = { icon = " ", color = "error", alt = { "BUG", "HACK", "FIXME", "FIXIT" } },
		WARN = { icon = " ", color = "warning", alt = { "WARN", "ISSUE" } },
		PERF = { icon = " ", color = "hint", alt = { "PERF" } },
	},
	merge_keywords = false, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		before = "", -- 'fg' or 'bg' or empty
		keyword = "wide", -- 'fg', 'bg', 'wide' or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- 'fg' or 'bg' or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = { "help", "qf", "man" }, -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of hilight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		-- regex that will be used to match keywords.
		pattern = [[\b(KEYWORDS):]],
	},
})

-- TODO :testing
-- FIXME :testing
-- FIXIT :testing
-- BUG :testing
-- HACK :testing
-- NOTE :testing
-- INFO :testing
-- ISSUE :testing
-- WARN :testing
-- PERF :testing
