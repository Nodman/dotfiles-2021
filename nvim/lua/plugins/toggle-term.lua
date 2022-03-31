local cmd = vim.cmd
local map = require('tools').map

require('toggleterm').setup({
  size = 15,
  start_in_insert = false,
  shade_terminals = true,
  shading_factor = 1,
  float_opts = {
    highlights = {
      border = 'FloatTermBorder',
      background = 'FloatTermNormal',
    },
  },
  direction = 'horizontal',
})

map(
  'n',
  '<leader>\\',
  '<CMD>exe v:count1 . "ToggleTerm"<CR>',
  { silent = true }
)

function _JestWatchFile()
  require('toggleterm').exec_command(
    [[cmd="npm run test -- --watch ]] .. vim.fn.expand('%:p') .. '"',
    1
  )
end

function _JestProject()
  require('toggleterm').exec_command([[cmd="npm run test"]], 1)
end

function _NpmRun(args)
  require('toggleterm').exec_command([[cmd="npm run ]] .. args .. '"', 1)
end

-- Jest integration
cmd('command! JestFile lua _JestWatchFile()')
cmd('command! JestProject lua _JestProject()')
cmd('command! -nargs=* NpmRun lua _NpmRun(<q-args>)')
