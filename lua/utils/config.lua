-- custom configures

local conf = {}

-- 操作系统
conf.os_name = vim.loop.os_uname().sysname
conf.is_windows = conf.os_name:lower():find('windows') ~= nil
conf.is_unix_like = not conf.is_windows

-- 架构
conf.arch = vim.loop.os_uname().machine
conf.arch_is_x86 = conf.arch:match("i[%d]86") or conf.arch == "x86_64"
conf.arch_is_arm = not conf.arch_is_x86

return conf
