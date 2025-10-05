local M = {}

M.on_attach = function(client, bufnr)
  -- Simple mapping function
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      desc = desc,
      noremap = true,
      silent = true,
    })
  end

  -- LSP mappings
  map("n", "<leader>ld", vim.lsp.buf.definition, "Go To Definition")
  map("n", "<leader>lD", vim.lsp.buf.declaration, "Go To Declaration")
  map("n", "<leader>li", vim.lsp.buf.implementation, "Go To Implementation")
  map("n", "<leader>lr", vim.lsp.buf.references, "Go To References")
  map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>ln", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
  map("v", "<leader>la", vim.lsp.buf.code_action, "Code Action")

  -- Diagnostics (updated to non-deprecated versions)
  map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Prev Diagnostic")
  map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next Diagnostic")
  map("n", "<leader>le", function()
    vim.diagnostic.open_float()
  end, "Show Diagnostic")
  map("n", "<leader>lq", vim.diagnostic.setloclist, "Set Location List")

  -- Spell check
  map("n", "<leader>sp", function()
    vim.wo.spell = not vim.wo.spell
    vim.notify("Spell check " .. (vim.wo.spell and "ON" or "OFF"))
  end, "Toggle Spell Check")

  -- Client setup
  if client.offset_encoding then
    client.offset_encoding = "utf-8"
  end

  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end
end

return M
