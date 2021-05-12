local dap = require'dap'

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.g.dap_root_path..'/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    type = 'node2',
    name = 'launch',
    request = 'launch',
    program = '${file}',
    -- program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    type = 'node2',
    name = 'attach',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
  }
}
