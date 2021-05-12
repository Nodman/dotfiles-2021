local opt = require'tools'.opt

-- vim.api.nvim_exec('autocmd BufEnter * lua require"completion".on_attach()', false)

opt('o', 'completeopt', 'menuone,noinsert,noselect')

vim.g.completion_sorting = "none"

vim.g.completion_matching_strategy_list = {'exact'}
vim.g.completion_matching_ignore_case = 0
vim.g.completion_matching_smart_case = 0
vim.g.completion_timer_cycle = 40
vim.g.completion_trigger_keyword_length = 2
