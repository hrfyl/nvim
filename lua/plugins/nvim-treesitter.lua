-- nvim-treesitter 代码高亮（main 分支新 API）
-- main 分支是重写版：nvim-treesitter.configs 模块已删除，高亮也不再自动开启，
-- 需要在 FileType 时自行调用 vim.treesitter.start()。
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,        -- main 分支不支持懒加载（README 明确说明）
  build = ":TSUpdate", -- 官方推荐 spec；:TSUpdate 仍然存在
  config = function()
    -- 需要 parser 的语言（承接旧配置的 ensure_installed）
    local languages = {
      "lua", "c", "cpp", "go", "python",
      "cmake", "json", "toml", "yaml", "ini",
      "vim", "vimdoc",
    }

    -- main 分支硬依赖 tree-sitter CLI（>= 0.26.1）：缺 CLI 时 install() 仍会逐个
    -- 下载 tarball、在编译阶段失败并刷一屏 ErrorMsg，故先做存在性检查。
    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install(languages)
    else
      vim.notify(
        "未找到 tree-sitter CLI，跳过 parser 安装；nvim 自带 parser 的 c/lua/markdown/vim/vimdoc 仍可高亮",
        vim.log.levels.WARN
      )
    end

    -- 承接旧配置的 highlight.enable + highlight.disable（大文件跳过）
    local max_filesize = 100 * 1024 -- 100 KB

    local function enable_highlight(buf)
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        -- nvim 自带 ftplugin（lua/markdown/query/help）会无条件 start()，
        -- 且注册早于本回调，故需补一次 stop() 才能让大文件真正跳过
        vim.treesitter.stop(buf)
        return
      end

      -- 无 parser 时 vim.treesitter.start() 内部是 assert，会直接抛错，
      -- 故用 language.add() 先行判断（官方推荐写法，失败时静默返回 nil）
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if lang and vim.treesitter.language.add(lang) then
        vim.treesitter.start(buf, lang)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitterHighlight", { clear = true }),
      callback = function(args)
        enable_highlight(args.buf)
      end,
      desc = "启用 treesitter 高亮（大文件跳过）",
    })

    -- 带文件参数启动时（nvim file.lua），FileType 在 basic.lua 的
    -- `filetype plugin indent on` 就触发了，早于本插件加载，autocmd 会错过它，
    -- 故对已加载的 buffer 补处理一次。
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
        enable_highlight(buf)
      end
    end
  end,
}
