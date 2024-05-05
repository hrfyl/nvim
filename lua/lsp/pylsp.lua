-- pylsp configure

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP atteches to a given buffer
local lspconfig = require('lspconfig')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', '<leader>jh', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>jd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>jK', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ji', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>gc', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- lookup 'which-key'
    local wk = require("which-key")
    wk.register({
      ["<leader>jk"] = "hover",
      ["<leader>jd"] = "definition",
      ["<leader>jh"] = "declaration",
      ["<leader>ji"] = "implementation",
      ["<leader>wa"] = "add_workspace_folder",
      ["<leader>wr"] = "remove_workspace_folder",
      ["<leader>wl"] = "list_workspace_folders",
      ["<leader>gr"] = "references",
      ["<leader>gc"] = "type_definition",
      ["<leader>rn"] = "rename",
      ["<leader>ca"] = "code_action",
      ["<leader>ff"] = "format file",
  })
end

lspconfig.pylsp.setup({
    on_attach = on_attach,
})
