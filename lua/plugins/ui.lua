-- [[ UI Configuration ]]

-- Colorscheme
vim.cmd.colorscheme('tokyonight-night')

-- Gitsigns
require('gitsigns').setup({
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	}
})

-- Lualine
require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'tokyonight',
		component_separators = '|',
		section_separators = '',
	},
	sections = {
		lualine_c = {
			{ 'filename', path = 1 }
		},
	},
})

-- Trouble
require('trouble').setup()
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble diagnostics' })
