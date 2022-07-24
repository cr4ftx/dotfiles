local nvim_treesitter_status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not nvim_treesitter_status_ok then
    return
end

nvim_treesitter.setup {
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
