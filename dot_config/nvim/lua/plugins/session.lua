return {
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        --post_restore_cmds = { change_nvim_tree_dir, "NvimTreeOpen" },
        -- pre_save_cmds = { "NvimTreeClose" },
      })
    end,
  },
}
