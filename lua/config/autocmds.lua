-- Enable spell check for non-code files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "rst", "asciidoc", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "pl" }
  end,
})
