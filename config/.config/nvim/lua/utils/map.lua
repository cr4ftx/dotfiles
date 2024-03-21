local map = function(m, l, r, o)
    local opts = { noremap = true, silent = true }
    vim.keymap.set(m, l, r, vim.tbl_extend("force", opts, o or {}))
end

return map
