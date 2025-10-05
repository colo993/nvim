local M = {}

M.on_attach = function(client, bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- LSP mappings
  map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go To Definition" })
  map("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go To Declaration" })
  map("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go To Implementation" })
  map("n", "<leader>lr", vim.lsp.buf.references, { desc = "Go To References" })
  map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
  map("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename Symbol" })

  -- Code Actions
  map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
  map("v", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })

  -- Diagnostics mappings
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  map("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
  map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Set Location List" })

  -- Toggle spell checking
  map("n", "<leader>sp", function()
    vim.wo.spell = not vim.wo.spell
    vim.notify("Spell check " .. (vim.wo.spell and "ON" or "OFF"))
  end, { desc = "Toggle Spell Check" })

  map("i", "<leader>sp", function()
    vim.wo.spell = not vim.wo.spell
    vim.notify("Spell check " .. (vim.wo.spell and "ON" or "OFF"))
  end, { desc = "Toggle Spell Check" })

  -- Explicitly register with which-key
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add({
      { "<leader>l", group = "LSP", buffer = bufnr, icon = "" },
      { "<leader>ld", desc = "Go To Definition", buffer = bufnr },
      { "<leader>lD", desc = "Go To Declaration", buffer = bufnr },
      { "<leader>li", desc = "Go To Implementation", buffer = bufnr },
      { "<leader>lr", desc = "Go To References", buffer = bufnr },
      { "<leader>lh", desc = "Hover", buffer = bufnr },
      { "<leader>ln", desc = "Rename Symbol", buffer = bufnr },
      { "<leader>la", desc = "Code Action", buffer = bufnr, mode = { "n", "v" } },
      { "<leader>le", desc = "Show Diagnostic", buffer = bufnr },
      { "<leader>lq", desc = "Set Location List", buffer = bufnr },
      { "<leader>s", group = "Spell", buffer = bufnr },
      { "<leader>sp", desc = "Toggle Spell Check", buffer = bufnr, mode = { "n", "i" } },
    })
  end

  -- Adjust client capabilities
  if client.offset_encoding then
    client.offset_encoding = "utf-8"
  end

  -- Disable ruff's hover in favor of Pyright
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end
end

return M
