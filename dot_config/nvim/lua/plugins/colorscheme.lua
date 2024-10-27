return {
  {
    "marko-cerovac/material.nvim",
    config = function()
      require("material").setup({
        plugins = {
          "gitsigns",
          "indent-blankline",
          "illuminate",
        },
        disable = {
          background = true,
        },
        contrast = {
          -- If the background is set to transparent,
          terminal = false, -- Enable contrast for the built-in terminal
          sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false, -- Enable contrast for floating windows
          cursor_line = true, -- Enable darker background for the cursor line
          lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
          non_current_windows = true, -- Enable contrasted background for non-current windows
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material",
    },
  },
}
