local tools = require'tools'

tools.opt('o', 'showmode', false)

local statusLineModeHl = '%#ModeBlock#'
local statusLineRest = table.concat({
  '%#GeneralBlock#',
  ' %t ',
  '%m',
  '%#GeneralBlock#',
  '%=',
  '%#GeneralBlock#',
  '%p%% ',
  '%l:%c ',
  '%#AccentBlock#',
  '%{&filetype} ',
})

local modesMap = {
  ['n']       = { name = 'nrm', color = '#8FBCBB' },
  ['i']       = { name = 'ins', color = '#B48EAD' },
  ['R']       = { name = 'rpl', color = '#81A1C1' },
  ['v']       = { name = 'vis', color = '#5E81AC' },
  ['V']       = { name = 'vln', color = '#5E81AC' },
  ['']      = { name = 'vbl', color = '#5E81AC' },
  ['c']       = { name = 'com', color = '#A3BE8C' },
  ['t']       = { name = 'ter', color = '#EBCB8B' },
}

local getModeAttrs = function()
  local mode = vim.api.nvim_get_mode().mode
  local attrs = modesMap[mode]

  if attrs == nil then
    attrs = { name = mode, color = modesMap['n']['color']}
  end


  return attrs
end

local updateModeColor = function(color)
  vim.api.nvim_exec( 'hi ModeBlock guifg='..color, false)
end

 ActiveStatusLine = function()
  local fileType = vim.bo.ft

  if fileType == 'NvimTree' then return ' ' end

  local modeAttrs = getModeAttrs()

  updateModeColor(modeAttrs.color)

  return string.format('%s  %s%s', statusLineModeHl, modeAttrs.name, statusLineRest)
end

vim.api.nvim_exec(
[[
  hi ModeBlock ctermbg=NONE ctermfg=110 guibg=NONE guifg=NONE
  hi statusline ctermbg=NONE guibg=NONE
  hi statuslinenc ctermbg=NONE guibg=NONE
  hi GeneralBlock ctermbg=NONE ctermfg=60 guifg=#616e88 guibg=NONE
  hi AccentBlock ctermbg=NONE ctermfg=222 guifg=#D08770 guibg=NONE
]], false)

tools.createAugroup({
  { 'WinEnter,BufEnter', '*', 'setlocal', 'statusline=%!v:lua.ActiveStatusLine()"' },
  { 'WinLeave,BufLeave', '*', 'setlocal', 'statusline=\\ \\ %#GeneralBlock#%t\\ %m' },
  { 'WinLeave,BufLeave', 'NvimTree', 'setlocal', 'statusline=\\ ' },
}, 'statusline_hl')

vim.o.statusline = ActiveStatusLine()
