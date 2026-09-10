-- gopls configure
-- 默认不加载（见 lsp/setup.lua）。需要 Go 支持时：
--   1. 安装 gopls：在 :Mason 中安装，或 go install golang.org/x/tools/gopls@latest
--   2. 取消 lua/lsp/setup.lua 中 require('lsp/gopls') 的注释
-- 用 :Mason 装的会被 mason-lspconfig 自动启用，下面一行覆盖 go install 等其它安装方式。
vim.lsp.config('gopls', {

})

vim.lsp.enable('gopls')
