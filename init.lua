require('vim._core.ui2').enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_banner = 0
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 25
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
	vim.diagnostic.jump({ count = -1 }) -- Jump to the previous diagnostic
end)
vim.keymap.set('n', ']d', function()
	vim.diagnostic.jump({ count = 1 }) -- Jump to the previous diagnostic
end)

vim.opt.relativenumber = true
vim.opt.nu = true

vim.opt.swapfile = false
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Jump up half page and set cursor to mid' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Jump down half page and set cursor to mid' })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.fn.expand('%:p')
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without replacing clipboard' })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Open Git Status' })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})


vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		if ev.data.spec.name == 'blink.cmp' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
			require('blink.cmp').build():wait(60000)
		end
	end,
})

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
}
vim.cmd.colorscheme('tokyonight-night')

require('gitsigns').setup({
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	}
})

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

require('nvim-treesitter').setup {
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath('data') .. '/site'
}

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'go', 'python', 'lua' },
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})

-- configuration nvim-treesitter-textobjects
require("nvim-treesitter-textobjects").setup {
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
}

-- keymaps
local treesitter_context = require('treesitter-context')
treesitter_context.setup({
	enable = true,
})
vim.keymap.set('n', 'jc', function()
	treesitter_context.go_to_context(vim.v.count1)
end, { silent = true })

-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "af", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)



require('trouble').setup()
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')


local harpoon = require("harpoon")
harpoon.setup({
	global_settings = {
		mark_branch = true,
	}
})
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

vim.keymap.set("n", "`a", harpoon_mark.add_file)
vim.keymap.set("n", "`e", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "`1", function() harpoon_ui.nav_file(1) end)
vim.keymap.set("n", "`2", function() harpoon_ui.nav_file(2) end)
vim.keymap.set("n", "`3", function() harpoon_ui.nav_file(3) end)
vim.keymap.set("n", "`4", function() harpoon_ui.nav_file(4) end)

require("telescope").setup(
	{
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
	}
)
pcall(require('telescope').load_extension, 'fzf')
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if not client then return end

		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

		vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, opts)
		vim.keymap.set('n', 'gI', function() require('telescope.builtin').lsp_implementations() end, opts)
		vim.keymap.set('n', '<leader>D', function() require('telescope.builtin').lsp_type_definitions() end, opts)
		vim.keymap.set('n', '<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end,
			opts)
		vim.keymap.set('n', '<leader>ws',
			function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, opts)

		vim.keymap.set('n', 'T', vim.diagnostic.open_float, opts)

		-- Lesser used LSP functionality
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end


		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			vim.keymap.set("n", '<leader>th', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				print(vim.lsp.inlay_hint.is_enabled() and 'Inlay hints are enabled' or
					'Inlay hints are disabled')
			end)
		end

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})


local blink_cmp = require('blink.cmp')

blink_cmp.setup({
	sources = {
		default = { 'lsp', 'path', 'buffer', 'snippets' },
	},
	completion = {
		menu = {
			draw = {
				columns = {
					{ "label",     "source_id", gap = 5, "label_description" },
					{ "kind_icon", gap = 3,     "kind" },
				},
			},
		},
	},
})




require("mason").setup()

local servers = {
	-- clangd = {},
	gopls = {
		cmd = { "gopls" },
		gopls = {
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				unusedvariable = true,
			},
			hints = {
				-- assignVariableTypes = true,
				-- compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		}
	},
	-- rust_analyzer = {},
	-- tsserver = {},
	html = {
		filetypes = { 'html', 'twig', 'hbs', 'tmpl', 'blade' },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true
			},
			provideFormatter = true
		}
	},
	intelephense = {
		filetypes = { "blade", "php" },
		environment = {
			-- phpExecuteable = load_project_specific_settings()
		},
	},
	lua_ls = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false },
			hint = { enable = true },
		},
	},
	pylsp = {
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = false,
					ignore = { 'W391' },
					maxLineLength = 100
				},
				pylint = { enabled = false },
				pyls_isort = { enabled = false },
				pylsp_mypy = { enabled = true },
				pylsp_black = { enabled = true },
				pyls_flake8 = { enabled = true }
			}
		}
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

for lsp, v in pairs(servers) do
	vim.lsp.config(lsp, {
		capabilities = capabilities,
		settings = v
	})
	vim.lsp.enable(lsp, true)
end
