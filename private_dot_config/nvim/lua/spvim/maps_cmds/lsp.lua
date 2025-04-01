local wk = require("which-key")

local function buf_fmt_async()
	require("conform").format()
end

wk.add({
	{ ";", group = "lsp" },
	{ ";A", vim.lsp.codelens.run, desc = "codelens-action" },
	{ ";a", vim.lsp.buf.code_action, desc = "code-action" },
	{ ";f", buf_fmt_async, desc = "formatter", mode = { "n", "x" } },
	{ ";r", vim.lsp.buf.rename, desc = "rename" },
	{ ";h", vim.lsp.buf.signature_help, desc = "signature-help" },
})
wk.add({
	{ ";g", group = "lsp navigation" },
	{ ";gS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "symbols-ws" },
	{ ";gd", "<cmd>Telescope lsp_definitions<cr>", desc = "definitions" },
	{ ";gi", "<cmd>Telescope lsp_implementations<cr>", desc = "implementations" },
	{ ";gr", "<cmd>Telescope lsp_references<cr>", desc = "references" },
	{ ";gs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols-file" },
	{ ";gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "typedef" },
})

local function diagnostic_jump_next()
	vim.diagnostic.jump({ count = vim.v.count1 })
end
local function diagnostic_jump_prev()
	vim.diagnostic.jump({ count = -vim.v.count1 })
end

vim.keymap.set("n", "[d", diagnostic_jump_next, {
	silent = true,
	desc = "goto next diagnostic",
})
vim.keymap.set("n", "]d", diagnostic_jump_prev, {
	silent = true,
	desc = "goto prev diagnostic",
})

-- show document
vim.keymap.set("n", "K", vim.lsp.buf.hover, {
	desc = "show document for the symbol under cursor",
})
vim.keymap.set("n", "M", "<cmd>Man<cr>", {
	desc = "show man page for the symbol under cursor",
})

vim.api.nvim_create_user_command("Format", buf_fmt_async, {
	desc = "lsp document formatting",
})

-- For Coqtail
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "coq" },
	callback = function(args)
		vim.g.coqtail_build_system = "prefer-coqproject"

		wk.add({
			buffer = args.buf,
			{ "<leader>c", group = "Coqtail" },
		})
	end,
})
-- For Cornelis Agda-Mode
local function agda_cmd()
	vim.ui.select({
		-- global
		"CornelisLoad",
		"CornelisGoals",
		"CornelisRestart",
		"CornelisAbort",
		"CornelisSolve ",
		"CornelisGoToDefinition",
		"CornelisPrevGoal",
		"CornelisNextGoal",
		"CornelisQuestionToMeta",
		"CornelisInc",
		"CornelisDec",
		"CornelisCloseInfoWindows",
		-- goal
		"CornelisGive",
		"CornelisRefine",
		"CornelisElaborate",
		"CornelisAuto",
		"CornelisMakeCase",
		"CornelisTypeContext",
		"CornelisTypeInfer",
		"CornelisTypeContextInfer",
		"CornelisNormalize",
		"CornelisWhyInScope",
		"CornelisHelperFunc",
	}, {
		prompt = "Cornelis Agda-Mode:",
		format_item = function(item)
			return "run " .. item
		end,
	}, function(item, idx)
		local _ = idx
		pcall(vim.cmd, item)
	end)
end
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "agda" },
	callback = function(args)
		wk.add({
			buffer = args.buf,
			{ "<leader>c", group = "Cornelis" },
			{ "<leader>cc", agda_cmd, desc = "commands" },
			{ "<leader>ca", "<cmd>CornelisAuto<CR>", desc = "auto" },
			{ "<leader>cl", "<cmd>CornelisLoad<CR>", desc = "load&check" },
			{ "<leader>cg", "<cmd>CornelisGoals<CR>", desc = "list goals" },
			{ "<leader>cr", "<cmd>CornelisRefine<CR>", desc = "refine" },
			{ "<leader>cd", "<cmd>CornelisMakeCase<CR>", desc = "case split" },
			{ "<leader>c,", "<cmd>CornelisTypeContext<CR>", desc = "goal&context" },
			{ "<leader>c.", "<cmd>CornelisTypeContextInfer<CR>", desc = "inferred type" },
			{ "<leader>cn", "<cmd>CornelisSolve<CR>", desc = "solve constraints" },
			{ "gd", "<cmd>CornelisGoToDefinition<CR>", desc = "goto definition" },
			{ "[c", "<cmd>CornelisPrevGoal<CR>", desc = "previous goal" },
			{ "]c", "<cmd>CornelisNextGoal<CR>", desc = "next goal" },
			{ "<C-A>", "<cmd>CornelisInc<CR>", desc = "inc" },
			{ "<C-X>", "<cmd>CornelisDec<CR>", desc = "dec" },
		})
	end,
	desc = "cornelis agda-mode",
	group = vim.api.nvim_create_augroup("agda-cornelis-group", {}),
})
