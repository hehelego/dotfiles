vim.g.maplocalleader = ','
local hop = require('hop')

-- see https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
local function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no
    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else
    no = o
  end
  return no
end
-- see https://stackoverflow.com/questions/1283388/how-to-merge-two-tables-overwriting-the-elements-which-are-in-both
local function merge(t1, t2)
  local ta = deepcopy(t1)
  local tb = deepcopy(t2)
  for k, v in pairs(tb) do
    if (type(v) == "table") and (type(ta[k] or false) == "table") then
      merge(ta[k], tb[k])
    else
      ta[k] = v
    end
  end
  return ta
end

-- require (neovim.version >= 0.7) for lua-function callback
local map_default_opt = {}
local function bind(mode, lhs, rhs, opts)
  if opts == nil then
    opts = {}
  end

  vim.keymap.set(
    mode,
    lhs,
    rhs,
    merge(map_default_opt,opts)
  )
end
local function leader(key)
  return '<localleader>' .. key
end

-- A wrapper is a function which takes an option table and returns a callback function.
-- type Wrapper = Table -> () -> Function
-- wrap :: Function -> Wrapper
local function wrap(hop_hint_func)
  return function(opts)
    return function() hop_hint_func(opts) end
  end
end
-- A bunch of wrappers
local hint = {
  char1      = wrap(hop.hint_char1),
  char2      = wrap(hop.hint_char2),
  words      = wrap(hop.hint_words),
  lines_head = wrap(hop.hint_lines_skip_whitespace),
  patterns   = wrap(hop.hint_patterns),
  anywhere   = wrap(hop.hint_anywhere),
}


--
-- SECTION: key bindings
--


bind({'n','x','o'}, leader('f'), hint.char1{})
-- TODO: implement till
bind({'n','x','o'}, leader('t'), hint.char1{ till=true })

bind({'n','x','o'}, leader('g'), hint.char2{})
-- TODO: implement till
bind({'n','x','o'}, leader('h'), hint.char2{ till=true })

bind({'n','x','o'}, leader('w'), hint.words{ })
-- TODO: implement word-end
bind({'n','x','o'}, leader('e'), hint.words{ till=true })

bind({'n','x','o'}, leader('j'), hint.lines_head{ })
-- TODO: implement line-end
bind({'n','x','o'}, leader('k'), hint.lines_head{ })

bind({'n','x','o'}, leader('/'), hint.patterns{ })

bind({'n','x','o'}, leader(','), hint.anywhere{ })


-- TODO: implement dot repeat
