local ibl_enabled = false

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      enabled = ibl_enabled,
    },
    config = function(_, opts)
      --   -- See `:help indent-blankline` for more information
      require('ibl').setup(opts)

      vim.keymap.set('n', '<leader>b', function()
        if ibl_enabled then
          vim.opt.listchars = listchars_default
          vim.cmd.IBLDisable()
          ibl_enabled = false
        else
          vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
          vim.cmd.IBLEnable()
          ibl_enabled = true
        end
      end, { desc = 'Toggle IBL' })
    end,
  },
}
