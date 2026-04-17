-- ~/.config/nvim/lua/colors/purple_lazyvim.lua
return {
  colorscheme = function()
    local colors = {
      bg = "#261f35", -- main background
      bg_alt = "#3d314f", -- secondary background
      fg = "#e8e3c9", -- creamy yellow
      primary = "#8fa7c4",
      secondary = "#c284a4",
      alert = "#c284a4",
      disabled = "#8fa7c4",
      binding_mode = "#c99ad1",
      visual = "#5c4170", -- brighter purple for selection
    }

    local hl = vim.api.nvim_set_hl

    -- Main text
    hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
    hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg })
    hl(0, "FloatBorder", { fg = colors.bg_alt, bg = colors.bg })

    -- Cursor and line
    hl(0, "CursorLine", { bg = colors.bg_alt })
    hl(0, "CursorLineNr", { fg = colors.primary, bold = true })
    hl(0, "Cursor", { fg = colors.bg, bg = colors.primary })

    -- Comments
    hl(0, "Comment", { fg = colors.disabled, italic = true })

    -- Keywords, functions, statements
    hl(0, "Keyword", { fg = colors.primary, bold = true })
    hl(0, "Function", { fg = colors.primary })
    hl(0, "Statement", { fg = colors.primary, bold = true })

    -- Strings, numbers, constants
    hl(0, "String", { fg = colors.secondary })
    hl(0, "Number", { fg = colors.secondary })
    hl(0, "Constant", { fg = colors.secondary })

    -- Errors / Warnings
    hl(0, "Error", { fg = colors.alert, bold = true })
    hl(0, "WarningMsg", { fg = colors.alert, bold = true })

    -- Search / Visual selection
    hl(0, "Search", { bg = colors.binding_mode, fg = colors.bg })
    hl(0, "Visual", { bg = colors.visual })

    -- Popup menu
    hl(0, "Pmenu", { bg = colors.bg_alt, fg = colors.fg })
    hl(0, "PmenuSel", { bg = colors.primary, fg = colors.bg })

    -- Line numbers
    hl(0, "LineNr", { fg = colors.disabled })

    -- Statusline
    hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg_alt })
    hl(0, "StatusLineNC", { fg = colors.disabled, bg = colors.bg })

    -- VertSplit
    hl(0, "VertSplit", { fg = colors.bg_alt, bg = colors.bg })

    -- LazyVim / Dashboard
    hl(0, "DashboardHeader", { fg = colors.primary, bg = colors.bg })
    hl(0, "DashboardCenter", { fg = colors.fg, bg = colors.bg })
    hl(0, "DashboardFooter", { fg = colors.secondary, bg = colors.bg })

    -- Telescope highlights
    hl(0, "TelescopeNormal", { bg = colors.bg })
    hl(0, "TelescopePromptNormal", { bg = colors.bg })
    hl(0, "TelescopeResultsNormal", { bg = colors.bg })
    hl(0, "TelescopePreviewNormal", { bg = colors.bg })
    hl(0, "TelescopeSelection", { bg = colors.visual, fg = colors.fg, bold = true })
    hl(0, "TelescopeMatching", { fg = colors.primary, bold = true })

    -- Which-key floating windows
    hl(0, "WhichKeyFloat", { bg = colors.bg })
  end,

  -- Load LazyVim defaults
  defaults = {
    autocmds = true,
    keymaps = true,
  },

  news = {
    lazyvim = true,
    neovim = false,
  },

  icons = {
    misc = { dots = "󰇘" },
    ft = { octo = " ", ["markdown.gh"] = " " },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = "" },
    git = { added = " ", modified = " ", removed = "" },
    kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Function = "󰊕 ",
      Keyword = " ",
      Method = "󰊕 ",
      Module = " ",
      Number = "󰎠 ",
      String = " ",
      Text = " ",
      Variable = "󰀫 ",
    },
  },

  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Property",
      "Struct",
      "Trait",
    },
  },
}
