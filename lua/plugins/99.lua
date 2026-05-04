local _99 = require('99')
_99.setup({
	provider = _99.Providers.GeminiCLIProvider
})

vim.keymap.set("v", "<leader>9v", function()
	_99.visual()
end)

vim.keymap.set("n", "<leader>9s", function()
	_99.search()
end)
