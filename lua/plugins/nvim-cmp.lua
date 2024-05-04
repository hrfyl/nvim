-- nvim-cmp
return {
  -- cmp-source
  { "hrsh7th/cmp-nvim-lsp", name = "nvim_lsp" },
  { "hrsh7th/cmp-buffer", name = "buffer" },
  { "hrsh7th/cmp-path", name = "path" },
  { "hrsh7th/cmp-cmdline", name = "cmdline" },
  -- vsnip
  { "hrsh7th/cmp-vsnip", name = "vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "rafamadriz/friendly-snippets" },
  -- lspkind
  { "onsails/lspkind-nvim" },
  -- nvim-cmp configure
  {
    "hrsh7th/nvim-cmp",
    -- event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      
      cmp.setup {
        -- 指定 snippet 引擎
        snippet = {
          expand = function(args)
            -- For `vsnip` users.
            vim.fn["vsnip#anonymous"](args.body)
            -- For `luasnip` users.
            -- require('luasnip').lsp_expand(args.body)
            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)
            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
          end,
        },
        -- 来源
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- For vsnip users.
          { name = 'vsnip' },
          -- For luasnip users.
          -- { name = 'luasnip' },
          -- For ultisnips users.
          -- { name = 'ultisnips' },
          -- For snippy users.
          -- { name = 'snippy' },
        }, {
          { name = 'buffer' },
          { name = 'path' }
        }),

        -- 快捷键
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(),     -- 上一个
          ['<C-j>'] = cmp.mapping.select_next_item(),     -- 下一个
          ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),  -- 出现补全
          ['<A-,>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),     -- 取消
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({
            select = true ,
            behavior = cmp.ConfirmBehavior.Replace
          }),     -- 确认
          -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        }),
        -- 使用lspkind-nvim显示类型图标
        formatting = {
          format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function (entry, vim_item)
              -- Source 显示提示来源
              vim_item.menu = "["..string.upper(entry.source.name).."]"
              return vim_item
            end
          })
        },
      }

      -- Use buffer source for `/`.
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
}
