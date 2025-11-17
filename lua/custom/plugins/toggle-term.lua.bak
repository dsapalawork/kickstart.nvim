return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      --[[ things you want to change go here]]
    },
    config = function()
      local terminal = require('toggleterm.terminal').Terminal
      local lazygit = terminal:new {
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd 'startinsert!'
        end,
      }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { desc = 'Open LazyGit in a terminal', noremap = true, silent = true })

      local bash = terminal:new {
        cmd = 'bash',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd [[call clearmatches()]]
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-;><C-;>', '<cmd>lua _bash_toggle()<CR>', { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function()
          vim.cmd 'startinsert!'
        end,
      }

      function _bash_toggle()
        bash:toggle()
      end

      vim.api.nvim_set_keymap('n', '<C-;>', '<cmd>lua _bash_toggle()<CR>', { desc = 'Open bash in a terminal', noremap = true, silent = true })
    end,
  },
}
