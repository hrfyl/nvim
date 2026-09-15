-- Comment 注释插件
return {
  'numToStr/Comment.nvim',
  opts = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    pre_hook = function(ctx)
      -- 修复 headless 模式下光标位置为 0 导致的 'start is higher than end' 错误
      -- see: https://github.com/numToStr/Comment.nvim/issues/375
      local row = vim.api.nvim_win_get_cursor(0)[1]
      if row == 0 then
        -- 移动光标到第一行
        vim.api.nvim_win_set_cursor(0, {1, 0})
      end
      -- 修复 Comment.nvim 在 nvim 0.12+ 的 treesitter API 兼容性问题
      -- 当 cursor 行为 0 且在 range 计算前被修正为 1 时，会导致 child:contains 返回 nil
      -- 此时跳过 treesitter 计算，直接返回 Neovim 原生 commentstring
      if row == 0 then
        local cstr = vim.bo.commentstring
        if cstr and cstr ~= '' and cstr:find('%%s') then
          return cstr
        end
      end
    end,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = '<leader>cc',    -- gcc
      ---Block-comment toggle keymap
      block = '<leader>cl',   -- gbc
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = '<leader>cc',    -- gc
      ---Block-comment keymap
      block = '<leader>cb',   -- gd
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = '<leader>cO',   -- gcO
      ---Add comment on the line below
      below = '<leader>co',   -- gco
      ---Add comment at the end of line
      eol = '<leader>cA',     -- gcA
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call after (un)comment
    post_hook = nil,
  },
  lazy = false,
}
