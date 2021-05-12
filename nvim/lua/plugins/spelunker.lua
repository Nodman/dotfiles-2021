local exec = vim.api.nvim_exec
local createAugroup = require('tools').createAugroup

vim.g.spelunker_check_type = 2
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_highlight_type = 2

exec('hi SpelunkerSpellBad guifg=NONE gui=undercurl', false)
exec('hi SpelunkerComplexOrCompoundWord guifg=NONE gui=NONE', false)

createAugroup({
  { 'CursorHold', '*.ts,*tsx,*.js,*.jsx,*.json,*.md,*.lua', 'call spelunker#check_displayed_words()' }
}, 'spelunker')

