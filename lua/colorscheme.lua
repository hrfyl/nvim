--- font size
vim.g.gui_font_default_size = 10
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Microsoft YaHei Mono"
-- vim.g.gui_font_face = "Source Code Pro"

RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

ResetGuiFont()

-- Keymaps
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>fd', function() ResetGuiFont() end, opts)
-- vim.keymap.set('n', '<leader>f+', function() ResizeGuiFont(1) end, opts)
-- vim.keymap.set('n', '<leader>f-', function() ResizeGuiFont(-1) end, opts)
local wk = require("which-key")
wk.add({
  { "<leader>fd", function() ResetGuiFont() end, desc = "reset font" },
  { "<leader>fk", function() ResetGuiFont(1) end, desc = "font size +" },
  { "<leader>fj", function() ResetGuiFont(-1) end, desc = "font size -" },
})
