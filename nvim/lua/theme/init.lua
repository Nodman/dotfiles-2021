local opt = require'tools'.opt
local hi = require('tools').hi
local hiLink = require('tools').hiLink
local exec = vim.api.nvim_exec
local palette = require('theme/nord').palette

exec('colorscheme nord', false)

-- remove ~ at the end of the buffer
opt('o', 'fcs', 'eob: ')

hiLink('MsgArea', 'Operator')
hiLink('CocExplorerGitDeleted', 'DiffDelete')

hi('CocExplorerNormalFloat', { guibg = palette.night0 })
hi('CocUnderline', { guifg = palette.green })
hi('CocExplorerNormalFloatBorder', { guibg = palette.night0, guifg = palette.night0 })
hi('CocErrorHighlight', { guisp = palette.red, gui = 'undercurl,italic', guibg = 'NONE', guifg = 'NONE' })
hi('CocHoverRange', { guifg='NONE', guibg='NONE', gui='underline' })

hi('VertSplit', { guibg = 'NONE', guifg = 'bg' })

-- Telescope
hi('TelescopeNormal', { guibg = palette.night0 })
hi('TelescopeBorder', { guibg = palette.night0, guifg = palette.night0 })

hi('TelescopePromptNormal', { guibg = palette.night0, guifg = palette.snow1 })
hi('TelescopePromptBorder', { guibg = palette.night0, guifg = palette.night0 })
hi('TelescopePromptPrefix', { guibg = palette.night0, guifg = palette.pink })
hi('TelescopePromptTitle', { guibg = palette.pink, guifg = palette.night1 })

hi('TelescopePreviewTitle', { guibg = palette.green, guifg = palette.night1 })

-- fine cmdline

hi('FineCmdlineNormal', { guibg = palette.night0, guifg = palette.snow1 })
hi('FineCmdlineBorder', { guibg = 'NONE', guifg = palette.night0 })

hi('QuickFixLine', { guibg = palette.frost2 })
hi('CursorLineNr', { guifg = palette.frost2 })

hi('CocFadeOut', { guibg = 'NONE', guifg = palette.night4 });

hi('SpelunkerSpellBad',  { guifg = 'NONE', gui = 'undercurl', guisp=palette.pink })
