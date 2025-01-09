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
    "Exafunction/codeium.vim",
    config = function()
      vim.g.codeium_no_map_tab = 1
      vim.keymap.set("i", "<c-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
    end,
  },
  "mattn/emmet-vim",
}
