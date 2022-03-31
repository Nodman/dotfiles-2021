local tools = require('tools')
local palette = require('theme.nord').palette

tools.opt('o', 'showmode', false)
tools.opt('o', 'laststatus', 3)

local statusLineRest = table.concat({
  '%#GeneralBlock#',
  ' %t ',
  '%m',
  '%#GeneralBlock#',
  '%=',
  '%#GeneralBlock#',
  '%p%% ',
  '%l:%c ',
  '%#ObsessionBlock#',
  '%{ObsessionStatus(" R ", " P ")}',
  '%#FtBlock#',
})

local modesMap = {
  ['n'] = { name = 'nrm', color = palette.frost4 },
  ['i'] = { name = 'ins', color = palette.pink },
  ['R'] = { name = 'rpl', color = palette.frost2 },
  ['v'] = { name = 'vis', color = palette.frost1 },
  ['V'] = { name = 'vln', color = palette.frost1 },
  [''] = { name = 'vbl', color = palette.frost1 },
  ['c'] = { name = 'com', color = palette.green },
  ['t'] = { name = 'ter', color = palette.yellow },
}

local ftMap = {
  javascript = 'js',
  javascriptreact = 'jsx',
  typescript = 'ts',
  typescriptreact = 'tsx',
}

local function getFt(ft)
  if ft == '' then
    return '-'
  end

  return ftMap[ft] or ft
end

local function getModeAttrs()
  local mode = vim.api.nvim_get_mode().mode
  local attrs = modesMap[mode]

  if attrs == nil then
    attrs = { name = mode, color = modesMap['n']['color'] }
  end

  return attrs
end

local function updateModeColor(color)
  vim.api.nvim_exec(
    'hi ModeBlock guibg=' .. color .. ' guifg=' .. palette.night1,
    false
  )
end

function ActiveStatusLine(winId)
  local currentWindowId = vim.api.nvim_get_current_win()

  if winId ~= currentWindowId then
    return ' '
  end

  local modeAttrs = getModeAttrs()

  updateModeColor(modeAttrs.color)

  return string.format(
    '%s %s %s %s ',
    '  %#ModeBlock#',
    modeAttrs.name,
    statusLineRest,
    getFt(vim.bo.ft)
  )
end

vim.api.nvim_exec([[
  hi statusline ctermbg=NONE guibg=NONE

  hi statuslinenc ctermbg=NONE guibg=NONE

  hi GeneralBlock ctermbg=NONE ctermfg=60 guifg=]] .. palette.night5 .. [[ guibg=NONE

  hi ObsessionBlock ctermbg=NONE ctermfg=222 guifg=]] .. palette.night1 .. [[ guibg=]] .. palette.red .. [[

  hi FtBlock ctermbg=NONE ctermfg=222 guifg=]] .. palette.night1 .. [[ guibg=]] .. palette.pink .. [[
]], false)

vim.o.statusline = '%!v:lua.ActiveStatusLine(g:statusline_winid)'
