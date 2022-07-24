local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local syntax = augroup('SyntaxSettings', { clear = true })

autocmd('BufNewFile,BufRead', {
  group = syntax,
  pattern = { '*.tsx' },
  command = 'set filetype=typescript.tsx'
})

autocmd('BufNewFile,BufRead', {
  group = syntax,
  pattern = { '.env*' },
  command = 'set filetype=sh'
})
