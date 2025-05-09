vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.cmd("setlocal expandtab")
    vim.cmd("setlocal tabstop=4") -- Python indentation: 4 spaces
    vim.cmd("setlocal softtabstop=4")
    vim.cmd("setlocal shiftwidth=4")
    vim.cmd("silent! %retab!") -- Convert existing tabs to spaces silently
    vim.cmd("silent! :%s/\\s\\+$//e") -- Optional: Remove trailing whitespace silently
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.cmd("setlocal expandtab")
    vim.cmd("setlocal tabstop=2") -- Lua indentation: 2 spaces
    vim.cmd("setlocal softtabstop=2")
    vim.cmd("setlocal shiftwidth=2")
    vim.cmd("silent! %retab!") -- Convert existing tabs to spaces silently
    vim.cmd("silent! :%s/\\s\\+$//e") -- Optional: Remove trailing whitespace silently
  end,
})

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

