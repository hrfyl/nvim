-- 加载配置文件
local config = require('utils/config')

-- lua_ls / pylsp：所有平台默认加载
require('lsp/lua')
require('lsp/pylsp')

-- clangd：仅 x86 平台（Windows / macOS / Linux），ARM 平台暂不支持 clangd
if config.arch_is_x86 then
    require('lsp/clangd')
else
    -- ARM 上显式禁用：mason-lspconfig 的 automatic_enable 会遍历 mason 本地
    -- 已装的包自动启用，若 mason 目录里残留 clangd 包仍会被启用并启动失败。
    -- 本行在 init.lua 中排在 lazynvim 之后，能覆盖 automatic_enable 的结果。
    vim.lsp.enable('clangd', false)
end

-- gopls：所有平台默认不加载。需要 Go 支持时先装 gopls
--（:Mason 里安装，或 go install golang.org/x/tools/gopls@latest），
-- 再取消下面一行的注释。
-- require('lsp/gopls')

-- 带文件参数启动时（nvim file.lua），FileType 在 basic.lua 的
-- `filetype plugin indent on` 就已触发、早于本配置加载，使 vim.lsp.enable
-- 内部的补处理（依赖 vim_did_enter / did_filetype，实测二者均为 0）被跳过，
-- 导致 LSP 不会 attach。这里显式补触发一次（与 nvim 内部 lsp.lua 做法一致）。
if vim.fn.exists('#nvim.lsp.enable#FileType') > 0 then
    vim.cmd.doautoall('nvim.lsp.enable FileType')
end
