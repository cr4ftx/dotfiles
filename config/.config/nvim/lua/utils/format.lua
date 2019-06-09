local M = {}

M.format = function()
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls" or client.name == "denols"
        end,
    })
end

return M
