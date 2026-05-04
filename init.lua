-- Neovim Configuration Entry Point

-- Enable core UI features if available
pcall(function() require('vim._core.ui2').enable() end)

-- Core settings
require('core.options')
require('core.keymaps')
require('core.autocmds')

-- Plugins and their configurations
require('plugins')
