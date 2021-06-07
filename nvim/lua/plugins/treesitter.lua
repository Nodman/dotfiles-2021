local ts_configs = require 'nvim-treesitter.configs'
local ts_install = require 'nvim-treesitter.install'

ts_configs.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = { "scss" }
  },
  indent = {enable = true},
}

ts_install.update()
