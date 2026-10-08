-- [[ Filetype Specific Configurations ]]
-- This file contains setup logic that should only run when specific filetypes are opened.

local augroup = vim.api.nvim_create_augroup('FiletypePluginConfigs', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function(ev)
		local ok = pcall(vim.treesitter.start, ev.buf)
		if ok then
			-- [[ Treesitter Configuration ]]
			require('nvim-treesitter').setup {
				-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = vim.fn.stdpath('data') .. '/site',

				highlight = {
					enable = true,
				},

				auto_install = true,
			}

			-- nvim-treesitter-textobjects
			require("nvim-treesitter-textobjects").setup {
				select = {
					lookahead = true,
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
					},
					include_surrounding_whitespace = false,
				},
			}

			-- treesitter-context
			local treesitter_context = require('treesitter-context')
			treesitter_context.setup({
				enable = true,
			})

			-- Keymaps
			vim.keymap.set('n', 'jc', function()
				treesitter_context.go_to_context(vim.v.count1)
			end, { silent = true, desc = 'Jump to context' })

			-- Treesitter Textobjects Keymaps
			vim.keymap.set({ "x", "o" }, "af", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.outer",
					"textobjects")
			end, { desc = 'Select outer function' })
			vim.keymap.set({ "x", "o" }, "if", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@function.inner",
					"textobjects")
			end, { desc = 'Select inner function' })
			vim.keymap.set({ "x", "o" }, "ac", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.outer",
					"textobjects")
			end, { desc = 'Select outer class' })
			vim.keymap.set({ "x", "o" }, "ic", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@class.inner",
					"textobjects")
			end, { desc = 'Select inner class' })
			vim.keymap.set({ "x", "o" }, "as", function()
				require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
			end, { desc = 'Select local scope' })
		end
	end,
})

-- Go configuration
vim.api.nvim_create_autocmd('FileType', {
	group = augroup,
	pattern = 'go',
	callback = function()
		-- Add the plugin only when a Go file is opened

		vim.pack.add({
			'https://github.com/buoto/gotests-vim',
			'https://github.com/olexsmir/gopher.nvim'
		})

		vim.keymap.set('n', '<leader>gt', '<cmd>GoTests<cr>')

		-- Setup gopher.nvim
		local ok, gopher = pcall(require, 'gopher')
		if ok then
			gopher.setup()
			vim.keymap.set('n', '<leader>aj', '<cmd> GoTagAdd json <CR>')
			vim.keymap.set('n', '<leader>ay', '<cmd> GoTagAdd yaml <CR>')
			vim.keymap.set('n', '<leader>ad', '<cmd> GoTagAdd db <CR>')
			vim.keymap.set('n', '<leader>ie', '<cmd> GoIfErr <CR>')
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	group = augroup,
	pattern = 'markdown',
	callback = function()
		vim.pack.add({
			'https://github.com/MeanderingProgrammer/render-markdown.nvim',
		})

		local ok, render_markdown = pcall(require, 'render-markdown')
		if ok then
			render_markdown.setup({
				completions = { lsp = { enabled = true } },
				quote = {
					enabled = true,
				},
				table = {
					enabled = true,
				},
			})
		end
	end
})
