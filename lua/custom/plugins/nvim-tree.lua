return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        hijack_cursor = true,
        system_open = {
          cmd = 'open',
        },
        update_focused_file = {
          update_root = true,
        },
        view = {
          signcolumn = 'auto',
          adaptive_size = 20,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              git = true,
              file = false,
              folder = false,
              folder_arrow = true,
            },
            glyphs = {
              folder = {
                arrow_closed = '⏵',
                arrow_open = '⏷',
              },
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '⌥',
                renamed = '➜',
                untracked = '★',
                deleted = '⊖',
                ignored = '◌',
              },
            },
          },
        },
        filters = {
          dotfiles = true,
        },
      }

      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Open nvim-tree', silent = true })
      -- TODO: come up with a good shortcut
      -- vim.keymap.set('n', '<leader>', ':NvimTreeFindFile<cr>', { desc = 'Open nvim-tree file finding', silent = true })
    end,
  },
}
