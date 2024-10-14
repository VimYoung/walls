-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- UI config
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5 --Move screen up and do>
vim.opt.scrolloff = 5
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.swapfile = false --Inhibit the use of swapfile.
vim.opt.list = true
vim.opt.listchars = {
  tab = "▷ ",
  trail = "·",
  -- extends = "◣",
  -- precedes = "◢",
  nbsp = "○",
}
--LSP settings
vim.lsp.inlay_hint.enable(false) -- Disable inline diagnostics.
-- Setting to activarte deep-ocean material theme.
vim.g.material_style = "deep ocean" --Setting desired style
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" --for auto-session.
