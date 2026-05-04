-- [[ LSP Configuration ]]

-- LSP Attach Autocommand
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

		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

		-- Enable auto-completion.
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		-- Inlay Hints
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			vim.keymap.set("n", '<leader>th', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				print(vim.lsp.inlay_hint.is_enabled() and 'Inlay hints are enabled' or
					'Inlay hints are disabled')
			end, { desc = 'Toggle Inlay Hints' })
		end

		-- Auto-format on save.
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

-- Blink CMP
require('blink.cmp').setup({
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

-- Mason
require("mason").setup()

-- Server Configurations
local server_settings = {
	gopls = {
		cmd = { "gopls" },
		gopls = {
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				unusedvariable = true,
			},
			hints = {
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		}
	},
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
	},
	lua_ls = {
		Lua = {
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

local on_init_servers = {
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
				    path ~= vim.fn.stdpath('config')
				    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using (most
					-- likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Tell the language server how to find Lua modules same way as Neovim
					-- (see `:h lua-module-load`)
					path = {
						'lua/?.lua',
						'lua/?/init.lua',
					},
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
						vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
						-- Depending on the usage, you might want to add additional paths
						-- here.
						-- '${3rd}/luv/library',
						-- '${3rd}/busted/library',
					},
					-- Or pull in all of 'runtimepath'.
					-- NOTE: this is a lot slower and will cause issues when working on
					-- your own configuration.
					-- See https://github.com/neovim/nvim-lspconfig/issues/3189
					-- library = vim.api.nvim_get_runtime_file('', true),
				},
			})
		end,
	},

}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

for server_name, v in pairs(server_settings) do
	vim.lsp.config(server_name, {
		on_init = on_init_servers[server_name],
		capabilities = capabilities,
		settings = v
	})
	vim.lsp.enable(server_name, true)
end
