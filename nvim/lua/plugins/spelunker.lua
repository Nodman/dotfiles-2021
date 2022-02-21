local createAugroup = require'tools'.createAugroup
local hi = require'tools'.hi

vim.g.spelunker_check_type = 2
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_highlight_type = 2

hi('SpelunkerComplexOrCompoundWord', { guifg='NONE', gui='NONE' })

createAugroup({
  { 'CursorHold', '*.ts,*tsx,*.js,*.jsx,*.json,*.md,*.lua', 'call spelunker#check_displayed_words()' }
}, 'spelunker')

