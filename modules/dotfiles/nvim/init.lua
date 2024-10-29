-- global 
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- plugins
require("plugins");

-- opts
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.o.hlsearch = false

-- appearance
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"
vim.cmd("colorscheme gruvbox")

-- keymaps
vim.keymap.set("n", "<leader>pv", ":Ex<CR>");

-- telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags)

-- harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<C-a>", harpoon_mark.add_file)
vim.keymap.set("n", "<C-q>", harpoon_ui.toggle_quick_menu)

-- gitsigns
-- TODO: setup vim-fugitive later
local gitsigns = require("gitsigns")
gitsigns.setup()
vim.opt.signcolumn = "yes"

