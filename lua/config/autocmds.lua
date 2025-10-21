-- Enable spell check for non-code files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "rst", "asciidoc", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "pl" }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.bo.expandtab = true
    vim.cmd("silent! %retab!")
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})
