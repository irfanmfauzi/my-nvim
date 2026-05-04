-- [[ Harpoon Configuration ]]

local harpoon = require("harpoon")
harpoon.setup({
	global_settings = {
		mark_branch = true,
	}
})

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

-- Keymaps
vim.keymap.set("n", "`a", harpoon_mark.add_file, { desc = 'Harpoon: Add file' })
vim.keymap.set("n", "`e", harpoon_ui.toggle_quick_menu, { desc = 'Harpoon: Toggle menu' })
vim.keymap.set("n", "`1", function() harpoon_ui.nav_file(1) end, { desc = 'Harpoon: Nav 1' })
vim.keymap.set("n", "`2", function() harpoon_ui.nav_file(2) end, { desc = 'Harpoon: Nav 2' })
vim.keymap.set("n", "`3", function() harpoon_ui.nav_file(3) end, { desc = 'Harpoon: Nav 3' })
vim.keymap.set("n", "`4", function() harpoon_ui.nav_file(4) end, { desc = 'Harpoon: Nav 4' })
