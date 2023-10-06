-- 基础配置
require('basic')            -- 基础配置
require('keybindings')      -- 基础映射

-- Packer插件管理
require('plugins')          -- 三方插件

-- other
require('autocmds')         -- auto command
require('colorscheme')      -- 主题配置

-- lsp和插件配置
require('plugins/setup')    -- 加载三方插件配置
require('lsp/setup')        -- 加载lsp配置
require('dap/setup')        -- 加载dap配置
require('utils/setup')      -- 加载utils配置
