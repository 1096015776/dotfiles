return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "bold", "italic" },
        constants = { "bold" },
        keywords = { "bold" },
        loops = { "italic", "bold" },
      },
      color_overrides = {},
      custom_highlights = function(C)
        return {
          RainbowDelimiterRed = { fg = "#FF5D62" },
          RainbowDelimiterYellow = { fg = "#E6C384" },
          RainbowDelimiterBlue = { fg = "#7FB4CA" },
          RainbowDelimiterOrange = { fg = "#FFA066" },
          RainbowDelimiterGreen = { fg = "#98BB6C" },
          RainbowDelimiterViolet = { fg = "#D27E99" },
          RainbowDelimiterCyan = { fg = "#7AA89F" },
          -- RainbowDelimiterRed = { fg = "#FF1A75" },
          -- RainbowDelimiterYellow = { fg = "#f1ff5e" },
          -- RainbowDelimiterBlue = { fg = "#28C9FF" },
          -- RainbowDelimiterOrange = { fg = "#FFAA54" },
          -- RainbowDelimiterGreen = { fg = "#5eff6c" },
          -- RainbowDelimiterViolet = { fg = "#bd5eff" },
          -- RainbowDelimiterCyan = { fg = "#33FFFF" },
          FloatBorder = { fg = C.yellow },
          ["@tag.tsx"] = { bold = true },
          ["@keyword.import.tsx"] = { italic = true, fg = C.red },
          ["@keyword.import.typescript"] = { italic = true, fg = C.red },
          ["@keyword.export.tsx"] = { italic = true, fg = C.red },
          ["@keyword.export.typescript"] = { italic = true, fg = C.red },
        }
      end,
      integrations = {
        telescope = {
          enabled = true,
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        flash = true,
        barbar = true,
        gitsigns = true,
        leap = true,
        neotree = true,
        neotest = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        semantic_tokens = true,
        mini = {
          enabled = true,
        },
        overseer = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        treesitter_context = true,
        treesitter = true,
        window_picker = true,
        rainbow_delimiters = true,
        symbols_outline = true,
        lsp_trouble = true,
        illuminate = {
          enabled = true,
          lsp = true,
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = false,
          },
        },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = true,
        undercurl = true,
        transparent = true,

        colors = {
          palette = {
            winterYellow = "#302e30",
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
                bg = "#1b1b23",
              },
            },
          },
        },

        overrides = function(colors)
          ---@type ThemeColors
          local theme = colors.theme
          local bit_lighter_than_bg = "#21212b"

          return {
            CursorLine = { bg = bit_lighter_than_bg },
            ColorColumn = { bg = bit_lighter_than_bg },
            CursorLineNr = { fg = theme.ui.float.fg },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            Folded = { bg = bit_lighter_than_bg },
            FloatBorder = { bg = theme.ui.float.bg, fg = theme.ui.float.bg },

            Winbar = { fg = theme.syn.fun },

            Directory = { fg = theme.syn.comment, italic = true },

            GitSignsAddInline = { bg = theme.syn.string, fg = theme.ui.float.bg },

            DiagnosticFloatingError = { fg = theme.diag.error, bg = "NONE" },
            DiagnosticFloatingWarn = { fg = theme.diag.warning, bg = "NONE" },
            DiagnosticFloatingInfo = { fg = theme.diag.info, bg = "NONE" },
            DiagnosticFloatingHint = { fg = theme.diag.hint, bg = "NONE" },
            DiagnosticFloatingOk = { fg = theme.diag.ok, bg = "NONE" },

            DiagnosticUnderlineWarn = { sp = theme.diag.warning, undercurl = true },
            DiagnosticUnderlineError = { sp = theme.diag.error, undercurl = true },

            LspReferenceWrite = { underline = false },

            LspDiagnosticsLineNrError = { fg = theme.diag.error },
            LspDiagnosticsLineNrWarning = { fg = theme.diag.warning },
            StatuslineError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
            StatuslineWarning = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
            StatuslineBoolean = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            OilDir = { fg = theme.syn.fun, italic = false },
          }
        end,
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        desc = "Clear LSP highlight groups",
        callback = function()
          local groups_to_highlight = { "@lsp.type.function" }

          for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            if not vim.tbl_contains(groups_to_highlight, group) then
              vim.api.nvim_set_hl(0, group, {})
            end
          end
        end,
      })

      vim.cmd.colorscheme("kanagawa")

      -- Avoid a black flicker on Neovim startup
      -- https://github.com/neovim/neovim/issues/19362#issuecomment-1924993842
      vim.print(" ")

      local id = vim.api.nvim_create_augroup("ColorsChanged", {})
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = id,
        pattern = "colors.lua",
        callback = function()
          vim.defer_fn(function()
            require("lazy.core.loader").reload("kanagawa.nvim")
            vim.cmd.KanagawaCompile()
          end, 2000)
        end,
      })
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "bold,italic",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
