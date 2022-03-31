local map = require('tools').map
local createAugroup = require('tools').createAugroup

-- set leader key
map('n', '<Space>', '<Nop>', { silent = true })
map('i', '<C-Space>', '<Nop>', { silent = true })
map('n', '<C-Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- enter command line faster
-- map('n', ';', ':')

-- don't invoke autocompletion menu due to accidental keystrokes
map('i', '<C-p>', '<Nop>')
-- use tab instead
map('i', '<TAB>', '<C-n>')

-- move in insert mode
map('i', '<C-h>', '<Left>')
map('i', '<C-l>', '<Right>')
map('i', '<C-k>', '<Up>')

-- move in command mode
map('i', '<C-j>', '<Down>')
map('c', '<C-h>', '<Left>')
map('c', '<C-l>', '<Right>')
map('c', '<C-k>', '<Up>')
map('c', '<C-j>', '<Down>')

-- faster init.lua access
map('', '<leader>fed', '<CMD>e $MYVIMRC<CR>')

-- reload lua file
map('', '<leader>feR', '<CMD>luafile %<CR>')

-- print file info
map(
  'n',
  '<Leader>if',
  '<CMD>echo printf("[%.2f KB] %s", wordcount().bytes / 1000.0, expand(@%))<CR>'
)

-- search selection in buffer
map('v', '//', 'y/\\V<C-r>=escape(@","/")<CR><CR>')
-- clear search highlight
map('n', '<Leader>sc', '<CMD>nohl<CR>')

-- leader key access to window
map('n', '<Leader>w', '<C-w>')
-- close window
map('n', '<Leader>wd', '<CMD>wd<CR>')
map('n', '<Leader>wm', '<CMD>lua require"utils".maximizeWindow()<CR>')
map('n', '<Leader>tm', '<CMD>lua require"utils".toggleAutoMaximizeWindow()<CR>')
-- resize vertically
map('n', '<Leader>H', '<CMD>vertical resize +5<CR>')
-- resize vertically
map('n', '<Leader>L', '<CMD>vertical resize -5<CR>')
-- switch windows by number
map('n', '<Leader>1', '<CMD>1wincmd w<CR>')
map('n', '<Leader>2', '<CMD>2wincmd w<CR>')
map('n', '<Leader>3', '<CMD>3wincmd w<CR>')
map('n', '<Leader>4', '<CMD>4wincmd w<CR>')

-- scroll through command mode with C-j and C-k
map('c', '<C-j>', '<C-n>')
map('c', '<C-k>', '<C-p>')
-- scroll through pop-up window with C-j and C-k and with tab
-- map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
-- map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<C-k>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
map('i', '<C-j>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })

-- exit buffer
map('n', '<Leader>bd', '<CMD>bn|:bd#<CR>')
-- wipe buffer
map('n', '<Leader>bw', '<CMD>bw<CR>')
map('n', '<Leader>bW', '<CMD>Wipe<CR>')
-- create new buffer
map('n', '<Leader>ba', '<CMD>badd<space>')
-- next buffer
map('n', '<Leader>bn', '<CMD>bn<CR>')
-- previous buffer
map('n', '<Leader>bp', '<CMD>bp<CR>')

-- next tab
map('n', '<Leader>tn', '<CMD>tabnext<CR>')
-- previous tab
map('n', '<Leader>tp', '<CMD>tabprevious<CR>')

-- duplicate line
map('n', '<Leader>ld', 'yyp')
-- copy to system clipboard
map('v', '<Leader>sy', '"+y')
-- paste from system clipboard
map('n', '<Leader>sp', '"+p')
map('n', '<Leader>sP', '"+P')

-- keep selection while indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

--exit terminal mode
map('t', '<C-n>', '<C-\\><C-n>')

--quickfix
map('n', '<Leader>q', '<CMD>cwindow<CR>')
map('n', '<Leader>Q', '<CMD>cclose<CR>')

-- alot of accidental presses
map('n', '<S-q>', '<nop>')

-- format buffer
createAugroup({
  {
    'FileType',
    'lua',
    'nnoremap <buffer> <leader>bf <CMD>lua require("stylua-nvim").format_file()<CR>',
  },
}, 'format_keymap')
