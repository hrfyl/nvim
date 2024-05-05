-- telescope
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  -- branch = "0.1.x",
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    "benfowler/telescope-luasnip.nvim",
  },
  config = function()
    local teles = require('telescope')

    teles.setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          }
        }
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      }
    })

    -- 加载拓展插件 - luasnip
    teles.load_extension('luasnip')

    -- register keymaps
    require('which-key').register({
      ["<leader>lf"] = { "<cmd>Telescope find_files<cr>", "find_file" },
      ["<leader>lg"] = { "<cmd>Telescope live_grep<cr>", "live_grep" },
      ["<leader>lb"] = { "<cmd>Telescope buffers<cr>", "find_buffer"},
      ["<leader>lh"] = { "<cmd>Telescope help_tags<cr>", "help_tags" },
      ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "lookup_symbols" },
    })
  end,
}
