local api = vim.api
local cmd = vim.cmd

local M = {}

M.guicursor = vim.o.guicursor
M.disableAutoMaximize = false

-- make scratch buffer
function M.makeScratch()
  -- equivalent to :enew
  api.nvim_command('enew')
  -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo[0].buftype='nofile'
  vim.bo[0].bufhidden='hide'
  vim.bo[0].swapfile=false
end

-- taken from https://github.com/neovim/neovim/issues/3688
function M.hideCursor()
   cmd('hi Cursor blend=100')

   -- for some reason unable to set through the M.opt
   cmd('set guicursor='..M.guicursor..',a:Cursor/lCursor')
end

function M.restoreCursor()

   cmd('hi Cursor blend=0')
   cmd('set guicursor='..M.guicursor)
end

-- for auto command
function M.autoMaximizeWindow()
  if M.disableAutoMaximize then return end

  M.maximizeWindow()
end

local function windowIsRelative(windowId)
  return vim.api.nvim_win_get_config(windowId).relative ~= ""
end

-- togle autoMaximize
function M.toggleAutoMaximizeWindow()
  M.disableAutoMaximize = not M.disableAutoMaximize
end

function M.maximizeWindow ()
  local currentWindowId = api.nvim_get_current_win()
  local windowsIds = api.nvim_list_wins()
  -- nothing to resize
  if #windowsIds < 2 or windowIsRelative(currentWindowId) then
    return
  end

  local minWidth = 20
  local totalWidth = 0
  local currentRow = vim.api.nvim_win_get_position(0)[1]
  local currentRowWindowIds = {}

  for _,id in ipairs(windowsIds) do
    if not windowIsRelative(id) then
      local y = vim.api.nvim_win_get_position(id)[1]
      if y == currentRow then
        totalWidth = totalWidth + api.nvim_win_get_width(id)
        table.insert(currentRowWindowIds, id)
      end
    end
  end

  local windowsInRow = #currentRowWindowIds

  -- nothing to resize
  if windowsInRow < 2 then return end

  local maximizedWidth = totalWidth - (windowsInRow - 1) * minWidth

  if maximizedWidth > minWidth and maximizedWidth > api.nvim_win_get_width(0) then
    for _,id in ipairs(currentRowWindowIds) do
      if (id == currentWindowId) then
        api.nvim_win_set_option(0, 'wrap', true)
        api.nvim_win_set_width(id, maximizedWidth)
      else
        api.nvim_win_set_option(id, 'wrap', false)
        api.nvim_win_set_width(id, minWidth)
      end
    end
  end
end

return M
