-- spinach/hehelego's neovim configuration
-- neovim.version >= SemVer(0,7,0)

local function L(mod)
	return require(mod)
end

-- basic setup
L("base")
-- plugin manager and plugin lists
L("plugins")
-- plugin configurations
L("config")
-- -- set keymaps/keybindings
L("keymaps")

-- my neovim-lua configuration is divided into the following five modules,
-- each has its own install-plugin,setup-config and set-keymap lua scripts
local mods = { "common", "ui", "editing", "tools", "langs", "misc" }
_ = mods



