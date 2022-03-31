-- some issue with neovim setting syntax on to late,
-- something that I did not understand
-- but was very interesting to read @bfredl @clason in gitter discussing this
vim.cmd('syntax enable')

-- key mappings
require('keymap')

-- nvim settings
require('settings')

-- via packer
require('plugins')

-- theme and UI settings
require('theme')

-- custom commands
require('commands')

-- statusline
require('statusline')
