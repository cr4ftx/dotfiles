local map = require("utils.map")

vim.g.mapleader = " "

map("n", "J", "mzJ`z")
map("n", "<s-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<s-h>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("t", "<esc>", "<C-\\><C-N>")
map({ "n" }, "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
