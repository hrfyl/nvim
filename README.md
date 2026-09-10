# nvim

个人 Neovim 配置，纯 Lua 编写，插件由 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理。

同一份仓库在 **Windows 10+ / macOS / Linux（x86_64 与 arm64）** 上共用，涉及平台的差异集中在 `lua/utils/config.lua` 一处判断。

当前开发环境为 Neovim 0.12.5。配置使用 0.11+ 的 `vim.lsp.config()` / `vim.lsp.enable()` API，**Neovim 0.11 以下无法工作**。

## 依赖

### 必需

| 工具 | 版本 | 用途 / 缺失后果 |
|---|---|---|
| [Neovim](https://github.com/neovim/neovim) | >= 0.11 | 全部配置依赖 0.11 起的 LSP API |
| git | >= 2.19 | lazy.nvim 拉取与更新插件 |
| [ripgrep](https://github.com/BurntSushi/ripgrep)（`rg`） | — | `<leader>lg` 全局搜索（`Telescope live_grep`），缺失则该功能不可用 |

### 可选

| 工具 | 用途 / 缺失后果 |
|---|---|
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | >= 0.26.1，用于编译安装 treesitter parser。缺失时启动会提示一次并跳过 parser 安装，只有 Neovim 自带的 c / lua / markdown / vim / vimdoc 有 treesitter 高亮 |
| `make` | **仅 Windows** 上需要，用于编译 LuaSnip 的 `jsregexp`（见 `lua/plugins/nvim-cmp.lua` 的 `build`） |
| [Nerd Font](https://www.nerdfonts.com/) | lualine、bufferline、nvim-tree 使用图标字符，缺失时显示为方块 |

## 安装

先备份已有配置（如果有），再 clone 到 Neovim 的配置目录。

### macOS / Linux

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null   # 备份，可选

git clone https://github.com/hrfyl/nvim.git ~/.config/nvim
```

### Windows

Windows 上 Neovim 读取的配置目录是 `%LOCALAPPDATA%\nvim`（**不是** `~/.config/nvim`），两种做法：

**方式 A：直接放进默认目录**

```powershell
git clone https://github.com/hrfyl/nvim.git "$env:LOCALAPPDATA\nvim"
```

**方式 B：仍放在 `~/.config/nvim`，再建符号链接**（本仓库当前采用的方式，路径与 macOS/Linux 统一）

```powershell
git clone https://github.com/hrfyl/nvim.git "$env:USERPROFILE\.config\nvim"

# 需要管理员权限，或在「设置 → 开发者选项」中开启开发者模式
cmd /c mklink /D "%LOCALAPPDATA%\nvim" "%USERPROFILE%\.config\nvim"
```

> 仓库地址也可用 SSH：`git@github.com:hrfyl/nvim.git`。

### 首次启动

```bash
nvim
```

`lua/lazynvim.lua` 会检测 lazy.nvim 是否存在，不存在时自动 clone 到数据目录（Windows 为 `%LOCALAPPDATA%\nvim-data\lazy`，其余平台为 `~/.local/share/nvim/lazy`），随后自动安装全部插件。**此过程需要联网**，耗时取决于网络状况，用 `:Lazy` 可以查看进度。

### 安装 LSP server

```vim
:Mason
```

默认会自动安装：

- `lua_ls` —— Lua（编辑本配置时自动生效）
- `pylsp` —— Python
- `clangd` —— C/C++，**仅 x86 平台**（Windows / macOS / Linux），ARM 上 clangd 尚不可用

需要 Go 支持时（`gopls` 各平台默认都不安装也不加载）：

```bash
go install golang.org/x/tools/gopls@latest   # 或在 :Mason 中安装
```

然后取消 `lua/lsp/setup.lua` 中 `require('lsp/gopls')` 一行的注释。

## 常用命令

| 目的 | 命令 |
|---|---|
| 插件管理界面 | `:Lazy` |
| LSP server 安装界面 | `:Mason` |
| 健康检查 | `:checkhealth` |
| 更新全部插件 | `nvim --headless "+Lazy! sync" +qa` |
| 按 lockfile 恢复插件版本 | `nvim --headless "+Lazy! restore" +qa` |
| 加载全部配置并暴露启动错误 | `nvim --headless -c qa` |

## 目录结构

```
init.lua              -- 入口，按固定顺序 require 各模块
lua/
├── basic.lua         -- 基础选项（leader、缩进、搜索、编码等）
├── lazynvim.lua      -- 自举 lazy.nvim 并加载 lua/plugins/
├── keybindings.lua   -- 全局键位，which-key 的分组前缀也在这里定义
├── autocmds.lua      -- 预留占位
├── colorscheme.lua   -- GUI 字体设置
├── lsp/
│   ├── setup.lua     -- LSP 加载入口与平台门控
│   ├── lua.lua       -- lua_ls
│   ├── pylsp.lua     -- pylsp，同时定义了 LSP 通用的缓冲区键位
│   ├── clangd.lua    -- clangd（仅 x86）
│   └── gopls.lua     -- gopls（默认不加载）
├── dap/setup.lua     -- 预留占位
├── utils/
│   ├── setup.lua     -- 预留占位
│   └── config.lua    -- 平台信息（操作系统、CPU 架构）
└── plugins/          -- 每个文件一个插件 spec，被自动导入
```

`init.lua` 的加载顺序固定为：

```
basic → lazynvim → keybindings → autocmds → colorscheme → lsp/setup → dap/setup → utils/setup
```

两点约定：

- **`lua/plugins/` 下的文件会被自动导入**（`require("lazy").setup("plugins")`），新增插件只需在该目录加一个 `return {...}` 的文件，不必注册。
- 一个 LSP server 涉及两个文件：`lua/plugins/mason.lua` 管**安装**（`ensure_installed`），`lua/lsp/<server>.lua` 管**配置**。增删语言工具链时两处要同步改。

## 插件一览

| 类别 | 插件 | 用途 |
|---|---|---|
| 主题 | `ellisonleao/gruvbox.nvim` | 配色方案（`priority = 1000`，最先加载） |
| 状态栏 | `nvim-lualine/lualine.nvim` | 底部状态栏 |
| 标签栏 | `akinsho/bufferline.nvim` | 顶部 buffer 标签 |
| 文件树 | `nvim-tree/nvim-tree.lua` | 侧边文件树 |
| 图标 | `nvim-tree/nvim-web-devicons` | 文件类型图标，被上面三者依赖 |
| 键位提示 | `folke/which-key.nvim` + `echasnovski/mini.nvim` | 按 leader 停顿后弹出可用键位 |
| 编辑 | `jiangmiao/auto-pairs` | 括号、引号自动配对 |
| 注释 | `numToStr/Comment.nvim` | `gcc` 等注释操作 |
| 查找 | `nvim-telescope/telescope.nvim`（固定 `tag = "0.1.6"`）+ `nvim-lua/plenary.nvim` + `benfowler/telescope-luasnip.nvim` | 文件 / 文本 / 符号模糊查找 |
| 补全 | `hrsh7th/nvim-cmp` | 补全引擎 |
| 补全源 | `hrsh7th/cmp-{buffer,path,cmdline,nvim-lsp,vsnip}`、`saadparwaiz1/cmp_luasnip` | 补全数据来源 |
| 代码片段 | `L3MON4D3/LuaSnip` + `rafamadriz/friendly-snippets` | 片段引擎与片段集 |
| 补全外观 | `onsails/lspkind-nvim` | 补全菜单图标 |
| 语法高亮 | `nvim-treesitter/nvim-treesitter` | 跟随 `main` 分支（重写版 API） |
| LSP | `neovim/nvim-lspconfig` | LSP 客户端 |
| LSP 安装 | `williamboman/mason.nvim` + `williamboman/mason-lspconfig.nvim` | server 的安装与启用 |

## 快捷键

leader 键是**空格**。按下空格停顿一下，which-key 会弹出当前可用的键位，不必全记。

前缀分组：

| 前缀 | 分组 | 前缀 | 分组 |
|---|---|---|---|
| `<leader>b` | buffer | `<leader>r` | 重命名 |
| `<leader>c` | 注释 | `<leader>s` | 搜索 / 设置 |
| `<leader>f` | 文件 / 字体 | `<leader>t` | 标签页 / 文件树 |
| `<leader>g` | 跳转 | `<leader>w` | 窗口 / 工作区 |
| `<leader>h` | 高亮 | `<leader>j` | 跳转（LSP） |
| `<leader>l` | 查找 | | |

常用键位：

| 键位 | 作用 |
|---|---|
| `<leader>fs` | 保存 |
| `<leader>q` / `<leader>Q` | 退出 / 不保存退出 |
| `<leader>bn` / `<leader>bp` / `<leader>bd` | 下一个 / 上一个 / 关闭 buffer |
| `<leader>tn` / `<leader>tp` / `<leader>td` | 下一个 / 上一个 / 关闭标签页 |
| `<leader>ww` / `<leader>wd` | 切换到其他窗口 / 关闭窗口 |
| `<leader>wv` / `<leader>ws` | 垂直分屏 / 水平分屏 |
| `<leader>hl` / `<leader>hc` | 切换行高亮 / 列高亮 |
| `<leader>fd` / `<leader>fk` / `<leader>fj` | 重置字体 / 放大 / 缩小（仅 GUI） |
| `fd`（插入模式） | 退出到普通模式 |
| `H` / `L` | 行首 / 行尾 |
| `U` / `Y` | 重做 / 复制到行尾 |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>`（插入模式） | 左 / 下 / 上 / 右 |

文件树与查找：

| 键位 | 作用 |
|---|---|
| `<leader>tt` / `<leader>tf` | 切换 / 聚焦文件树 |
| `<leader>tr` / `<leader>t?` | 切换根目录 / 文件树帮助 |
| `<leader>lf` / `<leader>lg` | 查找文件 / 全局搜索 |
| `<leader>lb` / `<leader>lh` / `<leader>ls` | buffer 列表 / 帮助标签 / 文档符号 |

LSP 键位在 `lua/lsp/pylsp.lua` 的 `on_attach` 中注册，打开对应语言的文件后生效：

| 键位 | 作用 |
|---|---|
| `<leader>jd` / `<leader>jh` / `<leader>ji` | 跳转定义 / 声明 / 实现 |
| `<leader>jk` / `<C-k>` | 悬停文档 / 签名帮助 |
| `<leader>gr` / `<leader>gc` | 查找引用 / 类型定义 |
| `<leader>rn` / `<leader>ca` | 重命名 / 代码操作 |
| `<leader>ff` | 格式化当前文件 |

## 注意事项

1. **Windows 的配置目录与 macOS/Linux 不同。** Neovim 在 Windows 上把 `stdpath("config")` 解析为 `%LOCALAPPDATA%\nvim`，数据目录为 `%LOCALAPPDATA%\nvim-data`。本仓库当前的做法是让配置目录成为一个指向 `~/.config/nvim` 的符号链接——所以**编辑这个仓库即编辑生效配置**，不要被两个路径绕晕。

2. **`lazy-lock.json` 未纳入版本控制。** 它被 `.gitignore` 忽略，clone 之后没有版本锁定，不同机器上的插件版本可能不一致。需要对齐时用 `:Lazy restore`，或自行维护该文件。

3. **LSP 按平台门控**（判据在 `lua/utils/config.lua`）：`lua_ls` / `pylsp` 全平台默认加载；`clangd` 只在 x86 平台加载，ARM 上不仅不加载、还会显式禁用——以避免 mason 目录里存在历史残留时被自动启用；`gopls` 各平台默认都不加载。

4. **treesitter 高亮依赖 tree-sitter CLI。** 没装 CLI 时启动会有一条提示，parser 不会被安装；装上之后可用 `:TSInstall <语言>` 补装，支持的语言列表见 `lua/plugins/nvim-treesitter.lua` 顶部。超过 100 KB 的文件会跳过 treesitter 高亮以免卡顿。

5. **GUI 字体写死在 `lua/colorscheme.lua`。** 默认值是 `Microsoft YaHei Mono`（仅 Windows 有该字体），且只对 neovide 等 GUI 客户端生效，终端里无效。mac / Linux 上请改成 `Source Code Pro` 或本机已有字体——该文件里已留了一行注释掉的 `Source Code Pro` 可参考。

6. **首次启动需要联网**：先自举 lazy.nvim，再拉取全部插件。

## License

MIT，见 [LICENSE](LICENSE)。
