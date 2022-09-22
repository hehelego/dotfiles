-- configuration for each installed LSP servers
local conf = {}

conf["pyright"] = {}

conf["rust_analyzer"] = {}

conf["sumneko_lua"] = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}

conf["gopls"] = {}

conf["clangd"] = {
	args = {
		"--background-index",
		"--pch-storage=memory",
		"-std=c++17",
		"--clang-tidy",
	},
}

conf["taxlab"] = {}

return conf
