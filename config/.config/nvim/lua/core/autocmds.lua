local M = require("utils.format")

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = M.format,
})
