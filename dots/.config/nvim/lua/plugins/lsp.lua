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
        volar = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          init_options = {
            vue = {
              hybridMode = false,
            },
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
    enabled = false,
    -- build = ":Codeium Auth",
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
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {
            border = "rounded",
            anchor = "NW",
            size = {
              max_width = 80,
              max_height = 10,
            },
            position = {
              row = 2,
              col = 2,
            },
          }, -- merged with defaults from documentation
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
}
