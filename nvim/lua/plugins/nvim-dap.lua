local map = require'tools'.map

-- configs
require'dap-configs/node'

require("dapui").setup()

vim.fn.sign_define('DapBreakpoint', { text='', texthl='GitGutterDelete', linehl='', numhl='' })
vim.fn.sign_define('DapLogPoint', {text='', texthl='GitGutterAdd', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='GitGutterChange', linehl='', numhl=''})

vim.g.dap_virtual_text = true


map('n', '<F5>', '<CMD>lua require"dap".continue()<CR>')
map('n', '<F10>', '<CMD>lua require"dap".step_over()<CR>')
map('n', '<F11>', '<CMD>lua require"dap".step_into()<CR>')
map('n', '<F12>', '<CMD>lua require"dap".step_out()<CR>')
map('n', '<leader>db', '<CMD>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dB', '<CMD>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dl', '<CMD>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map('n', '<leader>dr', '<CMD>lua require"dap".repl.open()<CR>')
map('v', '<leader>di', '<CMD>lua require"dap.ui.variables".visual_hover()<CR>')
map('n', '<leader>di', '<CMD>lua require"dap.ui.variables".hover()<CR>')

