local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
    return
end

telescope.setup {
    defaults = {
        file_ignore_patterns = { "^.git/" }
    },
    pickers = {
        find_files = {
            hidden = true,
        }
    }
}
