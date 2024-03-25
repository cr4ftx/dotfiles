local map = function(m, l, r, o)
    local defaultOpts = { noremap = true, silent = true }
    local opts = o or {}
    vim.keymap.set(m, l, r, vim.tbl_extend("force", defaultOpts, opts))
end

return map
