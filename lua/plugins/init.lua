-- [[ Plugin Management ]]

vim.pack.add {
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/theprimeagen/harpoon',
	'https://github.com/numToStr/Comment.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
	'https://github.com/folke/trouble.nvim',
	'https://github.com/saghen/blink.lib',
	'https://github.com/saghen/blink.cmp',
	'https://github.com/tpope/vim-fugitive',
	'https://github.com/mg979/vim-visual-multi',
	'https://github.com/f-person/git-blame.nvim',
	'https://github.com/christoomey/vim-tmux-navigator',
	'https://github.com/j-hui/fidget.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/folke/zen-mode.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter-context',
	'https://github.com/ThePrimeagen/99',
}

-- Load plugin configurations
require('plugins.ui')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.harpoon')
require('plugins.lsp')
require('plugins.99')
require('plugins.filetypes')

-- Simple plugins that don't need much config
require('Comment').setup()
require('fidget').setup({})
