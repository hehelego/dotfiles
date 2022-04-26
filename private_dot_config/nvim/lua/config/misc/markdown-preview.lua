-- See <https://github.com/iamcco/markdown-preview.nvim>

local function set(key, val)
	vim.g["mkdp_" .. key] = val
end

set("auto_start", 0)
set("auto_close", 0)
set("refresh_slow", 1)
set("open_to_the_world", 0)
set("browser", "qutebrowser")
set("echo_preview_url", 1)

set("page_title", "render(${name})")
