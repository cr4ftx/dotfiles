vim.g.mapleader = ' '

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')
map('n', '<A-l>', ':tabnext<CR>')
map('n', '<A-h>', ':tabprevious<CR>')

map('n', '<C-s>', ':NvimTreeFindFileToggle<CR>')
map('n', '<C-p>', ':Telescope find_files<CR>')
