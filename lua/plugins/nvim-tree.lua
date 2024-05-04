-- nvim 文件树
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true    
  end,
  opts = {
    sort_by = "case_sensitive",
    hijack_cursor = true,
    auto_reload_on_write = true,
    view = {
      centralize_selection = false,
      cursorline = true,
      debounce_delay = 15,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      width = 30,
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    sort = {
      sorter = "name",
      folders_first = true,
      files_first = false,
    },
    filters = {
      dotfiles = true,
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      full_name = false,
      root_folder_label = ":~:s?$?/..?",
      indent_width = 2,
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      symlink_destination = true,
      highlight_git = false,
      highlight_diagnostics = false,
      highlight_opened_files = "none",
      highlight_modified = "none",
      highlight_bookmarks = "none",
      highlight_clipboard = "name",
      indent_markers = {
        enable = false,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
        git_placement = "before",
        modified_placement = "after",
        diagnostics_placement = "signcolumn",
        bookmarks_placement = "signcolumn",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          modified = "●",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    on_attach = function(bufnr) -- custom keybindings
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', '<leader>t?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', '<leader>tr', api.tree.change_root_to_node, opts('chroot'))
      -- vim.keymap.set('n', '<leader>tt', api.tree.toggle, opts('Toggle'))
      -- vim.keymap.set('n', '<leader>tf', api.tree.focus, opts('Focus'))
    end
  },
  keys = {
    { "<leader>tf", ":NvimTreeFocus<cr>", desc = "NvimTreeFocus" },
    { "<leader>tt", ":NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
  },
}
