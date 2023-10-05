-- Leader key
vim.g.mapleader = ' '
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

-- reload vimrc file
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>')

-- 高亮当前行
vim.keymap.set('n', '<leader>hl', ':set cul!<CR>')
vim.keymap.set('n', '<leader>hc', ':set cuc!<CR>')

vim.keymap.set('n', '<leader>fs', ':w<CR>')
vim.keymap.set('n', '<leader>fw', ':w<CR>')

-- quit normal mode
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>Q', ':qa!<CR>')

-- insert mode shortcut
vim.keymap.set('i', '<C-h>', '<left>')      -- left
vim.keymap.set('i', '<C-j>', '<down>')      -- down
vim.keymap.set('i', '<C-k>', '<up>')        -- up
vim.keymap.set('i', '<C-l>', '<right>')     -- right
vim.keymap.set('i', '<C-a>', '<home>')      -- home
vim.keymap.set('i', '<C-e>', '<end>')       -- end
vim.keymap.set('i', '<C-d>', '<delete>')    -- delete

vim.keymap.set('n', '<leader>gd', '<C-]>')  -- goto definition
vim.keymap.set('n', '<leader>gh', '<C-o>')  -- backward
vim.keymap.set('n', '<leader>gl', '<C-i>')  -- forward

-- 搜索居中
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')

-- search
vim.keymap.set('n', '<leader>/', '/')
vim.keymap.set('n', '<leader>sc', ':set nohlsearch<CR>')

-- paste mode
vim.keymap.set('n', '<leader>sp', ':set paste<CR>')
vim.keymap.set('n', '<leader>snp', ':set nopaste<CR>')

-- buffer operation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')      -- buffer next
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>')  -- buffer previous
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')    -- buffer delete

-- tab operation
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>')     -- tab next
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>') -- tab previous
vim.keymap.set('n', '<leader>td', ':tabclose<CR>')    -- tab close

-- window operation
vim.keymap.set('n', '<leader>ww', '<C-w>w')   -- other window
vim.keymap.set('n', '<leader>wd', '<C-w>c')   -- close window
vim.keymap.set('n', '<leader>wj', '<C-w>j')   -- window below
vim.keymap.set('n', '<leader>wk', '<C-w>k')   -- window up
vim.keymap.set('n', '<leader>wh', '<C-w>h')   -- window left
vim.keymap.set('n', '<leader>wl', '<C-w>l')   -- window right
vim.keymap.set('n', '<leader>ws', '<C-w>s')   -- split window below
vim.keymap.set('n', '<leader>w-', '<C-w>-')   -- split window below
vim.keymap.set('n', '<leader>wv', '<C-w>v')   -- split window right
vim.keymap.set('n', '<leader>w|', '<C-w>|')   -- split window right

