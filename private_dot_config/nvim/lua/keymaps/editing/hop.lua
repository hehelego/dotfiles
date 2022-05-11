local hop = require("hop")

-- This function is used to create a wrapper from one hop.hint function.
-- A wrapper is a function, which
--   takes an option table and a callback executed after the motion,
--   returns a callback function that can be used.
local function hint_wrap(hop_hint_func)
	local wrapped = function(opts, after_cb)
		return function()
			hop_hint_func(opts)
			if after_cb ~= nil then
				after_cb()
			end
		end
	end
	return wrapped
end

-- A set of wrappers
local hint = {
	char1 = hint_wrap(hop.hint_char1),
	char2 = hint_wrap(hop.hint_char2),
	words = hint_wrap(hop.hint_words),
	lines = hint_wrap(hop.hint_lines),
	patterns = hint_wrap(hop.hint_patterns),
	anywhere = hint_wrap(hop.hint_anywhere),
}
-- A set of motion callbacks
local function motion_wrap(motion)
	local wrapped = function()
		vim.cmd("normal! " .. motion)
	end
	return wrapped
end

local motion = {
	-- move cursor left/right
	h = motion_wrap("h"),
	l = motion_wrap("l"),
	-- move to head of next word
	w = motion_wrap("w"),
	W = motion_wrap("W"),
	-- move to end  of next word
	e = motion_wrap("e"),
	E = motion_wrap("E"),
	-- move to head of prev word
	b = motion_wrap("b"),
	B = motion_wrap("B"),
	-- move to end  of prev word
	ge = motion_wrap("ge"),
	gE = motion_wrap("gE"),
	-- do nothing
	nop = function() end,
}
-- beginning of the line
motion["0"] = motion_wrap("0")
-- first non-whitespace character in current line
motion["^"] = motion_wrap("^")
-- last character of current line
motion["$"] = motion_wrap("$")

---
-- SECTION: key bindings
---

-- SEE https://github.com/phaazon/hop.nvim/issues/82
-- hop.nvim does not come with the vim-flavor inclusive/exclusive motion
-- we use afterwards_callback to achieve desired behavior

-- FIXME: inclusive/exclusive motion for operator-pending mode

local function bind(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, {
		silent = true,
		noremap = true,
	})
end
vim.g.maplocalleader = ","
local function leader(key)
	return "<localleader>" .. key
end

bind({ "n", "x", "v", "o" }, leader("f"), hint.char1({}, motion.nop))
bind({ "n", "x", "v", "o" }, leader("t"), hint.char1({}, motion.h))

bind({ "n", "x", "v", "o" }, leader("g"), hint.char2({}, motion.nop))
bind({ "n", "x", "v", "o" }, leader("h"), hint.char2({}, motion.h))

bind({ "n", "x", "v", "o" }, leader("w"), hint.words({}, motion.nop))
bind({ "n", "x", "v", "o" }, leader("e"), hint.words({}, motion.e))

bind({ "n", "x", "v", "o" }, leader("j"), hint.lines({}, motion["0"]))
bind({ "n", "x", "v", "o" }, leader("k"), hint.lines({}, motion["^"]))

bind({ "n", "x", "v", "o" }, leader("/"), hint.patterns({}, motion.nop))
bind({ "n", "x", "v", "o" }, leader(","), hint.anywhere({}, motion.nop))

-- register the keymap in which-key.nvim
require("which-key").register({
	name = "motion",

	f = "char1-f",
	t = "char1-t",
	g = "char2-f",
	h = "char2-t",
	w = "word-beg",
	e = "word-end",
	j = "line-beg",
	k = "line-end",
	["/"] = "pattern",
	[","] = "anywhere",
}, {
	mode = "n",
	silent = true,
	noremap = true,
	prefix = ",",
})

-- TODO: implement dot repeat
