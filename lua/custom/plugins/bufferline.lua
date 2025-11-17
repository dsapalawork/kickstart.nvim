return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        options = {
          mode = 'tabs',
          numbers = function(opts)
            return string.format('%s', opts.ordinal)
          end,
        },
      }
    end,
  },
}
