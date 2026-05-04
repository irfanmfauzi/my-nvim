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

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Jump up half page and set cursor to mid' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Jump down half page and set cursor to mid' })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Git Status (vim-fugitive)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
