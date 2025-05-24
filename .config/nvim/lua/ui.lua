return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          -- ['@keyword.lua'] = { bg = 'NONE' }, -- For keywords like 'local'
          -- ['@keyword.return.lua'] = { bg = 'NONE' }, -- For 'return'
          -- ['@function.builtin.lua'] = { bg = 'NONE' }, -- For 'require'
          -- ['@field.lua'] = { bg = 'NONE' }, -- For table keys like 'event', 'build'
          -- ['@property.lua'] = { bg = 'NONE' }, -- For table keys (captured here)
          -- ['@lsp.type.property.lua'] = { bg = 'NONE' }, -- LSP-specific property capture
          -- ['@variable.lua'] = { bg = 'NONE' }, -- For variables
          ['@variable'] = { bg = 'NONE' }, -- Fallback for linked group
          ['@property'] = { bg = 'NONE' }, -- Fallback for linked group
        },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
