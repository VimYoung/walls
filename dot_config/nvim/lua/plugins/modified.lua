return {
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = {
      config = {
        center = {
          {
            action = "lua LazyVim.pick()()",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = 'lua LazyVim.pick("oldfiles")()',
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = 'lua LazyVim.pick("live_grep")()',
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>Telescope chezmoi find_files<cr>")
            end,
            desc = " Config",
            icon = " ",
            key = "c",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>SessionSearch<cr>")
            end,
            desc = " Show Sessions",
            icon = " ",
            key = "s",
          },
          {
            action = "LazyExtras",
            desc = " Lazy Extras",
            icon = " ",
            key = "x",
          },
          {
            action = "Lazy",
            desc = " Lazy",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      max_width = function()
        return math.floor(vim.o.columns * 0.40)
      end,
      stages = "slide",
      render = "wrapped-compact",
    },
    --Modify notify to compact and remove dash from white spaces. Disable suggestions in comment.
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "NvimTree",
        "lazy",
      },
      under_cursor = false,
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function()
  --     require("cmp").setup({
  --       enabled = function()
  --         -- disable completion in comments
  --         local context = require("cmp.config.context")
  --         -- keep command mode completion enabled when cursor is in a comment
  --         if vim.api.nvim_get_mode().mode == "c" then
  --           return true
  --         else
  --           return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
  --         end
  --       end,
  --     })
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 20,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- autoformat = false,
      inlay_hints = { enabled = false },
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
