-- load which-key
local wk = require("which-key")

wk.add({
  { "<leader>b", group = "+buffer" },
  { "<leader>bc", group = "+close" },
  { "<leader>c", group = "+comment-code" },
  { "<leader>f", group = "+file-font" },
  { "<leader>g", group = "+goto" },
  { "<leader>h", group = "+highlight" },
  { "<leader>j", group = "+jump" },
  { "<leader>l", group = "+lookup" },
  { "<leader>r", group = "+rename-remove" },
  { "<leader>s", group = "+search-set" },
  { "<leader>sn", group = "+no" },
  { "<leader>t", group = "+tab-tree" },
  { "<leader>w", group = "+window-workspace" },
})

vim.keymap.set('i', 'fd', '<esc>')

-- basic
vim.keymap.set('v', 'v', '<esc>')   -- quit visual mode
vim.keymap.set('n', 'U', '<C-r>')   -- redo
vim.keymap.set('n', 'Y', 'y$')      -- yank to the end of line

-- move to the start of line
vim.keymap.set('n', 'H', '^')
vim.keymap.set('v', 'H', '^')
-- move to the end of line
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$')

-- -- reload vimrc file
-- vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')
-- vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>')

-- -- 高亮当前行
-- vim.keymap.set('n', '<leader>hl', ':set cul!<CR>')
-- vim.keymap.set('n', '<leader>hc', ':set cuc!<CR>')
wk.add({
  { "<leader>hl", ":set cul!<cr>", desc = "hightlight line" },
  { "<leader>hc", ":set cuc!<cr>", desc = "hightlight word" },
})

-- vim.keymap.set('n', '<leader>fs', ':w<CR>')
-- vim.keymap.set('n', '<leader>fw', ':w<CR>')
wk.add({
  { "<leader>fs", ":w<cr>", desc = "save file" },
  { "<leader>fs", ":w<cr>", desc = "write file" },
})

-- -- quit normal mode
-- vim.keymap.set('n', '<leader>q', ':q<CR>')
-- vim.keymap.set('n', '<leader>Q', ':qa!<CR>')
wk.add({
  { "<leader>q", ":q<cr>", desc = "quit" },
  { "<leader>Q", ":qa!<cr>", desc = "quit without save" },
})

-- -- insert mode shortcut
vim.keymap.set('i', '<C-h>', '<left>')      -- left
vim.keymap.set('i', '<C-j>', '<down>')      -- down
vim.keymap.set('i', '<C-k>', '<up>')        -- up
vim.keymap.set('i', '<C-l>', '<right>')     -- right
vim.keymap.set('i', '<C-a>', '<home>')      -- home
vim.keymap.set('i', '<C-e>', '<end>')       -- end
vim.keymap.set('i', '<C-d>', '<delete>')    -- delete

-- vim.keymap.set('n', '<leader>gd', '<C-]>')  -- goto definition
-- vim.keymap.set('n', '<leader>gh', '<C-o>')  -- backward
-- vim.keymap.set('n', '<leader>gl', '<C-i>')  -- forward
wk.add({
  { "<leader>gd", "<C-]>", desc = "goto definition" },
  { "<leader>gh", "<C-o>", desc = "backward" },
  { "<leader>gl", "<C-i>", desc = "forward" },
})

-- 搜索居中
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')

-- -- search
-- vim.keymap.set('n', '<leader>/', '/')
-- vim.keymap.set('n', '<leader>sc', ':set nohlsearch<CR>')
wk.add({
  { "<leader>/", "/", desc = "goto search" },
  { "<leader>sc", ":set nohlsearch<cr>", desc = "set nohlsearch" },
})

-- -- paste mode
-- vim.keymap.set('n', '<leader>sp', ':set paste<CR>')
-- vim.keymap.set('n', '<leader>snp', ':set nopaste<CR>')
wk.add({
  { "<leader>sp", ":set paste<cr>", desc = "set paste" },
  { "<leader>snp", ":set nopaste<cr>", desc = "set nopaste" },
})

-- -- buffer operation
-- vim.keymap.set('n', '<leader>bn', ':bnext<CR>')      -- buffer next
-- vim.keymap.set('n', '<leader>bp', ':bprevious<CR>')  -- buffer previous
-- vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')    -- buffer delete
wk.add({
  { "<leader>bn", ":bnext<cr>", desc = "buffer next" },
  { "<leader>bp", ":bprevious<cr>", desc = "buffer previous" },
  { "<leader>bd", ":bdelete<cr>", desc = "buffer close" },
  { "<leader>bcc", ":bdelete<cr>", desc = "buffer close" },
})

-- -- tab operation
-- vim.keymap.set('n', '<leader>tn', ':tabnext<CR>')     -- tab next
-- vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>') -- tab previous
-- vim.keymap.set('n', '<leader>td', ':tabclose<CR>')    -- tab close
wk.add({
  { "<leader>tn", ":tabnext<cr>", desc = "tab next" },
  { "<leader>tp", ":tabprevious<cr>", desc = "tab previous" },
  { "<leader>td", ":tabclose<cr>", desc = "tab close" },
  { "<leader>tc", ":tabclose<cr>", desc = "tab close" },
})

-- -- window operation
-- vim.keymap.set('n', '<leader>ww', '<C-w>w')   -- other window
-- vim.keymap.set('n', '<leader>wd', '<C-w>c')   -- close window
-- vim.keymap.set('n', '<leader>wj', '<C-w>j')   -- window below
-- vim.keymap.set('n', '<leader>wk', '<C-w>k')   -- window up
-- vim.keymap.set('n', '<leader>wh', '<C-w>h')   -- window left
-- vim.keymap.set('n', '<leader>wl', '<C-w>l')   -- window right
-- vim.keymap.set('n', '<leader>ws', '<C-w>s')   -- split window below
-- vim.keymap.set('n', '<leader>w-', '<C-w>-')   -- split window below
-- vim.keymap.set('n', '<leader>wv', '<C-w>v')   -- split window right
-- vim.keymap.set('n', '<leader>w|', '<C-w>|')   -- split window right
wk.add({
  { "<leader>ww", "<C-w>w", desc = "other window" },
  { "<leader>wd", "<C-w>c", desc = "close window" },
  { "<leader>wc", "<C-w>c", desc = "close window" },
  { "<leader>wj", "<C-w>j", desc = "window below" },
  { "<leader>wh", "<C-w>h", desc = "window left" },
  { "<leader>wl", "<C-w>l", desc = "window right" },
  { "<leader>ws", "<C-w>s", desc = "split window below" },
  { "<leader>w-", "<C-w>-", desc = "split window below" },
  { "<leader>wv", "<C-w>v", desc = "split window right" },
  { "<leader>w|", "<C-w>|", desc = "split window right" },
})
