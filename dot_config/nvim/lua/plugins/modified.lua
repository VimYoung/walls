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
        completion = {
          border = "rounded",
          winhighlight = "Normal:MyHighlight",
          winblend = 0,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:MyHighlight",
          winblend = 0,
        },
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
      cmdline = {
        view = "cmdline",
      },
      presets = {
        lsp_doc_border = true,
      },
      popupmenu = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { hidden = true, default_text = line })()
      end

      local function find_command()
        if 1 == vim.fn.executable("rg") then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif 1 == vim.fn.executable("fd") then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("fdfind") then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
          return { "find", ".", "-type", "f" }
        elseif 1 == vim.fn.executable("where") then
          return { "where", "/r", ".", "*" }
        end
      end

      return {
        defaults = {
          preview = {
            treesitter = false, -- Disables Treesitter in Telescope preview
          },
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        -- char = "│",
        -- tab_char = "│",
        -- char = { "-" },
        -- tab_char = { "-" },
      },
    },
  },
}
