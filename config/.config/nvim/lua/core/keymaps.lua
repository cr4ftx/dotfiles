local M = require("utils.format")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<c-o>", "<c-o>zzzv", opts)
vim.keymap.set("n", "<c-i>", "<c-i>zzzv", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "<s-l>", "<cmd>tabnext<cr>", opts)
vim.keymap.set("n", "<s-h>", "<cmd>tabprevious<cr>", opts)
vim.keymap.set("t", "<esc>", "<C-\\><C-N>", opts)
vim.keymap.set({ "n", "v" }, "<leader>f", M.format, opts)
vim.keymap.set({ "n" }, "<leader>l", "<cmd>Lazy<cr>", opts)
