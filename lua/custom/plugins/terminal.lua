return {
  {
    'rebelot/terminal.nvim',
    config = function()
      require('terminal').setup {
        layout = { open_cmd = 'botright new' },
        cmd = { vim.o.shell },
        autoclose = false,
      }

      local term_map = require 'terminal.mappings'
      vim.keymap.set({ 'n', 'x' }, '<leader>ts', term_map.operator_send, { expr = true })
      vim.keymap.set('n', '<leader>to', term_map.toggle)
      vim.keymap.set('n', '<leader>tO', term_map.toggle { open_cmd = 'enew' })
      vim.keymap.set('n', '<leader>tr', term_map.run)
      vim.keymap.set('n', '<leader>tR', term_map.run(nil, { layout = { open_cmd = 'enew' } }))
      vim.keymap.set('n', '<leader>tk', term_map.kill)
      vim.keymap.set('n', '<leader>t]', term_map.cycle_next)
      vim.keymap.set('n', '<leader>t[', term_map.cycle_prev)
      vim.keymap.set('n', '<leader>tl', term_map.move { open_cmd = 'belowright vnew' })
      vim.keymap.set('n', '<leader>tL', term_map.move { open_cmd = 'botright vnew' })
      vim.keymap.set('n', '<leader>th', term_map.move { open_cmd = 'belowright new' })
      vim.keymap.set('n', '<leader>tH', term_map.move { open_cmd = 'botright new' })
      vim.keymap.set('n', '<leader>tf', term_map.move { open_cmd = 'float' })

      local lazygit = require('terminal').terminal:new {
        layout = { open_cmd = 'float', height = 0.9, width = 0.9 },
        cmd = { 'lazygit' },
        autoclose = true,
      }
      vim.env['GIT_EDITOR'] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
      vim.api.nvim_create_user_command('TermLazygit', function(args)
        lazygit.cwd = args.args and vim.fn.expand(args.args)
        lazygit:toggle(nil, true)
      end, { nargs = '?' })
      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>TermLazygit<CR>', { desc = 'Open LazyGit in a terminal', noremap = true, silent = true })

      local htop = require('terminal').terminal:new {
        layout = { open_cmd = 'float', height = 0.9, width = 0.9 },
        cmd = { 'htop' },
        autoclose = true,
      }
      vim.api.nvim_create_user_command('TermHtop', function()
        htop:toggle(nil, true)
      end, { nargs = '?' })
      vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>TermHtop<CR>', { desc = 'Open htop in a terminal', noremap = true, silent = true })

      local python = require('terminal').terminal:new {
        layout = { open_cmd = 'botright vertical new' },
        cmd = { 'python3' },
        autoclose = true,
      }
      vim.api.nvim_create_user_command('TermPython', function()
        python:toggle(nil, true)
        local bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set('x', '<leader>ts', function()
          vim.api.nvim_feedkeys('"+y', 'n', false)
          python:send '%paste'
        end, { buffer = bufnr })
        vim.keymap.set('n', '<leader>t?', function()
          python:send(vim.fn.expand '<cexpr>' .. '?')
        end, { buffer = bufnr })
      end, {})

      vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'TermOpen' }, {
        callback = function(args)
          if vim.startswith(vim.api.nvim_buf_get_name(args.buf), 'term://') then
            vim.cmd [[call clearmatches()]]
            -- vim.cmd 'startinsert'
          end
        end,
      })

      vim.api.nvim_create_autocmd('TermOpen', {
        command = [[setlocal nonumber norelativenumber winhl=Normal:NormalFloat]],
      })
    end,
  },
}
