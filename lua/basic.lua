-- basicsinit
vim.cmd('syntax on')   --  开启语法高亮
vim.cmd('filetype plugin indent on') -- 自动侦测文件类型
vim.opt.number         = true        -- 显示行号
vim.opt.relativenumber = false       -- 相对行号
vim.opt.termguicolors  = true
vim.opt.shiftround     = true
vim.opt.updatetime     = 100         -- updatetime
vim.opt.cursorline     = true        -- 高亮当前行
vim.opt.autowrite      = true        -- 自动保存
if (vim.fn.has('termguicolors') == 1) then
    vim.opt.termguicolors = true
end

-- Leader key
vim.g.mapleader = ' '

-- utf-8
vim.g.encoding       = "UTF-8"
vim.opt.fileencoding = 'utf-8'

-- jk移动光标时上下保留5行
vim.opt.scrolloff     = 5
vim.opt.sidescrolloff = 5

-- 统一缩进
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4

-- 新行对齐当前行,使用空格代替tab
vim.opt.expandtab     = true
vim.opt.autoindent    = true
vim.opt.smartindent   = true

-- 搜索非大小写敏感
vim.opt.smartcase     = true
vim.opt.ignorecase    = true

-- 搜索高亮
vim.opt.hlsearch      = true

-- 边输入边搜索
vim.opt.incsearch     = true

-- 使用增强状态栏后不再需要 vim 的模式提示
vim.opt.showmode      = false

-- 命令行高为1
vim.opt.cmdheight     = 1

-- 当文件被外部程序修改时，自动加载
vim.opt.autoread      = true
-- vim.bo.autoread       = true

-- 禁止创建备份文件
vim.opt.backup        = false
vim.opt.swapfile      = false
vim.opt.writebackup   = false
