-- nvim-tree 配置

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- keybindings
local function nvim_tree_keybindings(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<leader>t?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '<leader>tr', api.tree.change_root_to_node, opts('Up'))
  vim.keymap.set('n', '<leader>tt', api.tree.toggle, opts('Toggle'))
  vim.keymap.set('n', '<leader>tf', api.tree.focus, opts('Focus'))
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  hijack_cursor = true,  -- 高亮当前
  view = {
    width = 30,
  },
  filters = {
    dotfiles = true,
  },
  renderer = {
    group_empty = true,
  },
  on_attach = nvim_tree_keybindings
})

-- keybindings for editor
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')
