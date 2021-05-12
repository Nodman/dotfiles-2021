-- some issue with neovim setting syntax on to late,
-- something that I did not understand
-- but was very interesting to read @bfredl @clason in gitter discussing this
vim.cmd'syntax enable'

-- key mappings
require'keymap'

-- nvim settings
require'settings'

-- via packer
require'plugins'

-- theme and UI settings
require'theme'

-- custom commands
require'commands'

-- per plugin specific settings (should come at the bottom to pick up all the settings and key maps)
-- require'plugins/lspinstall'
-- require'plugins/completion'
-- require'plugins/lspsaga'
-- require'plugins/nvim-tree'

-- statusline
require'statusline'
