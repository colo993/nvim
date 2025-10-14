return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Pin to main branch for stability
    build = ":TSUpdate",
    dependencies = {
      -- Essential for text objects
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- Shows the context of the code you're in (e.g., function name) at the top
      "nvim-treesitter/nvim-treesitter-context",
      -- Automatically adds/renames closing HTML tags
      "windwp/nvim-ts-autotag",
      {
        -- For Django templates (htmldjango parser)
        "g-hyuga/nvim-treesitter-django",
        url = "git@github.com:interdependence/tree-sitter-htmldjango.git",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "rust",
          "toml",
          "typescript",
          "yaml",
          "c",
          "htmldjango", -- Parser for Django templates
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          -- Using this option may improve performance
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = false },

        -- == Feature Configurations ==
        autotag = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>", -- Start selection
            node_incremental = "<cr>", -- Increment to the parent node
            node_decremental = "<bs>", -- Decrement to the previous node
            scope_incremental = "<tab>", -- Use for selecting scope
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Vimspection-style next/previous argument/parameter bindings
            keymaps = {
              -- You can use the default mappings
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
          },
        },
      })

      -- Configuration for nvim-treesitter-context
      require("treesitter-context").setup({
        enable = true,
        max_lines = 1, -- Only show one line of context
      })
    end,
  },
}
