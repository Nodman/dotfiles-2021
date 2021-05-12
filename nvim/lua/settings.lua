local opt = require('tools').opt
local createAugroup = require('tools').createAugroup

local indent = 2;

-- root path for debug adapters
vim.g.dap_root_path =  os.getenv('HOME')..'/.dap';

createAugroup({
  { 'WinEnter,FocusGained', '*', 'lua require"utils".autoMaximizeWindow()' },
}, 'window_resize')

-- hybrid line numbers with auto toggle
createAugroup({
  { 'BufEnter', '*.js,*.jsx,*.ts,*.tsx,*.json,*.md,*.lua', 'set relativenumber' },
  { 'BufLeave', '*.js,*.jsx,*.ts,*.tsx,*.json,*.md,*.lua', 'set norelativenumber' },
}, 'hybryd_lnr')

-- highlight line with cursor
opt('o', 'updatetime', 100)
-- highlight line with cursor
opt('w', 'cursorline', true)
-- size of indent
opt('b', 'shiftwidth', indent)
-- number of spaces tabs counts for
opt('b', 'tabstop', indent)
-- insert spaces when TAB is pressed.
opt('b', 'expandtab', true)
-- enable sign column
opt('w', 'signcolumn', 'yes:1')
-- set number column width
opt('w', 'numberwidth', 2)
-- hybrid line numbers
opt('w', 'rnu', true)
opt('w', 'nu', true)
-- allow backspace over everything in insert mode
opt('o', 'backspace', 'indent,eol,start')
-- round indents
opt('o', 'shiftround', true)
-- ignore case
opt('o', 'ignorecase', true)
-- don't ignore case with capitals
opt('o', 'smartcase', true)
-- support true colours
opt('o', 'termguicolors', true)
-- command line completion
opt('o', 'wildmenu', true)
-- allow to search in sub directories
opt('o', 'path', vim.o.path..'**')
-- don't give ins-completion-menu messages
opt('o', 'shortmess', vim.o.shortmess..'c')
-- timeout length
opt('o', 'ttimeoutlen', 100)
-- use 'magic' patterns (extended regular expressions)
opt('o', 'magic', true)
-- show matching brackets
opt('o', 'showmatch', true)
-- enable list chars
opt('w', 'list', true)
opt('w', 'listchars', 'tab:› ,trail:·,extends:>,precedes:<,nbsp:~')
-- split rules
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
--
opt('o', 'wildignore', vim.o.wildignore..'*/node_modules/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,package-lock.json')
--
opt('o', 'spell', false)
opt('o', 'spellfile', vim.fn.stdpath('config')..'/spell/en.utf-8.add')
-- python version
opt('o', 'pyx', 3)
--
opt('o', 'secure', true)
