local _99 = require('99')

_99.setup({
	provider = function()
		local cwd = vim.fn.getcwd()
		if string.find(cwd, "/bri/") then
			return _99.Providers.KiroCLIProvider
		else
			return _99.Providers.AgyCLIProvider
		end
	end,
})

vim.keymap.set("v", "<leader>9v", function()
	_99.visual()
end)

vim.keymap.set("n", "<leader>9s", function()
	_99.search()
end)

--- if you have a request you dont want to make any changes, just cancel it
vim.keymap.set("n", "<leader>9x", function()
	_99.stop_all_requests()
end)
