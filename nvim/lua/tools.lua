local api = vim.api
local cmd = vim.cmd
local M = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}
local guicursor = vim.o.guicursor

-- vim set helper
function M.opt(scope, key, value)

  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-- vim keymap helper

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}

  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- create auto groups
function M.createAugroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

return M
