-- NOT USED
local tools = require'tools'
local nt_view = require'nvim-tree.view'
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_show_icons = {
  ['git'] = 0,
  ['folders'] = 1,
  ['files'] = 1,
}

vim.g.nvim_tree_bindings = {
  ["h"] = tree_cb('close_node'),
  ["l"] = tree_cb('edit'),
}

local M = {}

function M.togggleCursor()
  if vim.bo.ft == 'NvimTree' then
    tools.hideCursor()
  else
    tools.restoreCursor()
  end
end

function M.togleNvimTree()
  if nt_view.win_open() then
      nt_view.close()
  else
      require'nvim-tree'.find_file(true)
  end
end

return M
