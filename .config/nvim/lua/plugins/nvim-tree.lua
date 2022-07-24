local nvim_tree_status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_status_ok then
    return
end

nvim_tree.setup({
    sort_by = 'case_sensitive',
    reload_on_bufenter = true,
    view = {
        adaptive_size = true,
        hide_root_folder = true,
        mappings = {
            list = {
                { key = 'u', action = 'dir_up' },
            },
        }
    },
    git = {
        ignore = false
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    }
})
