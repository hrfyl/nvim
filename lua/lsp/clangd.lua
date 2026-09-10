-- clangd configure

vim.lsp.config('clangd', {

})

-- 显式启用，不依赖 mason-lspconfig 的 automatic_enable：
-- 后者只遍历 mason 本地已装的包，而系统自带的 clangd（macOS 的 /usr/bin/clangd）
-- 不经过 mason，仅靠它不会被启用。与 lua/lsp/gopls.lua 的写法保持一致。
vim.lsp.enable('clangd')
