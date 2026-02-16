vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/snippets")

local function pascal_case(str)
  -- normalize separators to spaces
  str = str:gsub("[^%w]+", " ")
  -- capitalize every word and join
  return (str:gsub("(%w)(%w*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)):gsub(" ", "")
end

vim.keymap.set("s", "<leader>p", function()
  local filename = vim.fn.expand("%:t:r") -- my-name.use-case
  local main_part = filename:match("^[^.]+") -- my-name
  local name = pascal_case(main_part)
  vim.cmd("normal! " .. name)
end, { desc = "Convert word to PascalCase" })
