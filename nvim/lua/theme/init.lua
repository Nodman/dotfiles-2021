local opt = require'tools'.opt
local exec = vim.api.nvim_exec

require('theme/nord')

-- remove ~ at the end of the buffer
opt('o', 'fcs', 'eob: ')
exec('hi VertSplit guifg=#2E3440 guibg=bg', false)
exec('hi! link MsgArea Operator', false)
exec('hi! link CocExplorerGitDeleted DiffDelete', false)
