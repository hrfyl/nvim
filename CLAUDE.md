# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概述

个人 Neovim 配置（纯 Lua），需同时运行在 **Windows 10+、macOS、Linux（x86_64 / arm64）** 上，插件由 lazy.nvim 管理。仓库没有测试、lint 或 CI —— 验证改动的唯一方式是让 nvim 实际加载它。注释与提交信息使用中文，提交信息带 `[CHG]` / `[ADD]` 前缀。

## 常用命令

以下命令在仓库根目录、Git Bash 下执行：

| 目的 | 命令 |
|---|---|
| 加载全部配置并暴露启动错误 | `nvim --headless -c qa` |
| 单文件 Lua 语法检查（只编译不执行） | `nvim --headless -c "lua print(select(2, loadfile('lua/lsp/lua.lua')) or 'OK')" -c qa` |
| 按 lockfile 恢复插件版本 | `nvim --headless "+Lazy! restore" +qa` |
| 同步/更新插件 | `nvim --headless "+Lazy! sync" +qa` |
| 健康检查 | `nvim --headless "+checkhealth" +qa` |

运行时交互命令：`:Lazy`（插件管理）、`:Mason`（LSP server 安装）、`:checkhealth`。

## 加载链

`init.lua` 按固定顺序 require 各模块：`basic` → `lazynvim` → `keybindings` → `autocmds` → `colorscheme` → `lsp/setup` → `dap/setup` → `utils/setup`。新增顶层模块需在此登记。

`lua/lazynvim.lua` 先自举 lazy.nvim（缺失时 git clone 到 `stdpath("data")/lazy/lazy.nvim`），再用 `require("lazy").setup("plugins", ...)` 自动导入 `lua/plugins/` 下的所有文件 —— **新增插件只需在该目录加一个 `return {...}` 的文件，不必手动注册**。lockfile 固定为 `stdpath("config")/lazy-lock.json`。

注意：Windows 上 `stdpath("config")` 解析为 `~/AppData/Local/nvim`，该路径是指向本仓库 `~/.config/nvim` 的 SymbolicLink。编辑本仓库即编辑生效配置，不要被路径差异误导。

## 平台适配（重要）

这份配置要**同时在 Windows 10+、macOS、Linux（x86_64 与 arm64）上使用**，且是多台机器共用的同一份仓库。改动任何逻辑时都必须考虑其余平台，不要引入只在当前平台上成立的假设——例如硬编码绝对路径、平台专属的 shell 命令或可执行文件名、写死的路径分隔符、假定某个外部工具一定存在。依赖外部程序时用 `vim.fn.executable()` 之类的运行时检测（见 `lua/plugins/nvim-treesitter.lua` 对 `tree-sitter` CLI 的处理），不要按平台硬编码；需要区分平台时用下面的信息表。

`lua/utils/config.lua` 返回平台信息表（`is_darwin`、`is_windows`、`is_unix_like`、`arch_is_x86`、`arch_is_arm`），是条件加载的唯一来源。当前 LSP 门控规则：**`lua_ls` / `pylsp` 全平台默认加载；`clangd` 仅 `arch_is_x86` 平台启用（Windows / macOS / Linux，ARM 上 clangd 不可用）；`gopls` 全平台默认不加载**，需要 Go 支持时由用户自行安装（`:Mason` 或 `go install golang.org/x/tools/gopls@latest`）后取消 `lua/lsp/setup.lua` 中 `require('lsp/gopls')` 的注释。改语言工具链时 `lua/lsp/setup.lua`（管启用）与 `lua/plugins/mason.lua`（管安装）必须同步改。

ARM 侧的 `clangd` 需要在 `lsp/setup.lua` 里显式 `vim.lsp.enable('clangd', false)`：mason-lspconfig 的 `automatic_enable` 不看平台，会遍历 mason 本地已装的包自动启用（迁移、共享 mason 目录时最容易踩到）。`init.lua` 把 `lsp/setup` 排在 `lazynvim` 之后，正是为了让这一行能覆盖它——调整 require 顺序时不要破坏这个前提。

配置目录本身也是平台相关的：mac/Linux 上 `stdpath("config")` 就是 `~/.config/nvim`；当前这台 Windows 机器上它解析为 `~/AppData/Local/nvim`，且是指向本仓库的 SymbolicLink。引用配置目录时一律走 `vim.fn.stdpath("config")`，不要写死路径。

## LSP 的两层结构

改 LSP 通常需要同时看这两处：

1. **装哪些 server** —— `lua/plugins/mason.lua` 顶部的 `lsp_plugins` 表（按平台条件增删），传给 mason-lspconfig 的 `ensure_installed`。mason 只负责安装，不管配置。
2. **怎么配 server** —— `lua/lsp/<server>.lua`，由 `lua/lsp/setup.lua` require 并按平台门控。

配置已迁移到 Neovim 0.11+ 的新 API（当前 nvim 0.12.5）：用 `vim.lsp.config("<server_name>", {...})` 注册，**第一个参数必须是 server 名**（如 `lua_ls`、`pylsp`）。`on_attach` 内的缓冲区键位用 `vim.keymap.set` 注册，并紧跟着用 `wk.add` 补 which-key 描述（见 `lua/lsp/pylsp.lua`）。

## 约定

- **键位**：leader 为空格。需要在 which-key 中显示描述的用 `wk.add({ ... desc = ... })`；纯映射用 `vim.keymap.set`。前缀分组在 `lua/keybindings.lua` 顶部统一定义。`lua/keybindings.lua` 与 `lua/colorscheme.lua` 里保留了被注释掉的旧 `vim.keymap.set` 写法，是被 `wk.add` 取代的历史痕迹——改动时沿用在用的那一种，不要照抄注释里的写法。
- **插件 spec**：一个文件可 `return` 单个 spec（`nvim-tree.lua`）或 spec 数组（`nvim-cmp.lua`）。配置有 `opts` 声明式与 `config = function()` 命令式两种，仓库内混用。
- **treesitter**：插件跟随重写后的 `main` 分支，已无 `configs` 模块，高亮由 `lua/plugins/nvim-treesitter.lua` 里的 `FileType` autocmd 调 `vim.treesitter.start()` 完成（无 parser 时需靠 `vim.treesitter.language.add()` 守卫，否则 `start()` 内的 assert 会抛错）。新增语言时把语言名加进该文件的 `languages` 列表；装 parser 需先有 `tree-sitter` CLI（>=0.26.1），再用 `:TSInstall`。
- **启动时序陷阱（重要）**：`nvim <文件>` 启动时，FileType 在 `basic.lua` 的 `filetype plugin indent on` 就已触发，早于 `lazynvim` 加载的所有插件——此刻 `vim_did_enter` 与 `did_filetype()` 均为 0（实测）。因此**注册在插件 config 里的 FileType autocmd 会完全错过启动文件**。凡是依赖 FileType 的配置都必须额外补处理一次，目前有两处：`lua/plugins/nvim-treesitter.lua` 在注册 autocmd 后遍历已加载 buffer，`lua/lsp/setup.lua` 末尾执行 `doautoall 'nvim.lsp.enable FileType'`（替代 nvim 内置补处理，后者因条件不满足而被跳过，表现为 `nvim <文件>` 时 LSP 完全不 attach）。改动这两处时不要删掉。
- `lua/autocmds.lua`、`lua/dap/setup.lua`、`lua/utils/setup.lua` 目前是空占位，其 `require` 是为了预留加载点。
- `lazy-lock.json` 被 `.gitignore` 忽略且未纳入版本控制，clone 后没有版本锁定。

## 外部依赖

README 要求 `ripgrep`（telescope 搜索使用）。
