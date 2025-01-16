return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
        exclude = {
          "typescriptreact",
          "javascriptreact",
          "javascript",
          "typescript",
        },
      },
      codelens = {
        enabled = false,
      },
      servers = {
        biome = {
          settings = {
            single_file_support = true,
          },
        },
      },
      setup = {},
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        --lua
        "stylua",
        "selene",
        "shellcheck",
        "shfmt",

        -- frontend
        "html-lsp",
        "css-lsp",
        "eslint-lsp",
        "biome",
        "prettier",
        "typescript-language-server",
        "vetur-vls",
        -- markdown
        "markdownlint",
        "marksman",
        -- docker
        "hadolint",
        "codelldb",
      },
    },
  },
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = vim.g.ai_cmp,
      virtual_text = {
        enabled = not vim.g.ai_cmp,
        key_bindings = {
          accept = "<c-g>", -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    },
  },
  "mattn/emmet-vim",
}
