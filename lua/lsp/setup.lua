-- 加载配置文件
local config = require('utils/config')

-- 加载lua lsp配置
require('lsp/lua')

-- 加载pylsp配置
require('lsp/pylsp')

-- 加载golsp配置
require('lsp/gopls')

-- -- 加载clangd配置
if config.arch_is_x86 then
    require('lsp/clangd')
end
