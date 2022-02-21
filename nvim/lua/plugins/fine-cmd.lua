local map = require('tools').map

map('n', ';', '<CMD>lua require("fine-cmdline").open()<CR>', {silent = true})

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    prompt = ' :'
  },
  popup = {
    buf_options = {
      filetype = 'FineCmdlinePrompt'
    },
    relative = "editor",
    position = {
      row = '10%',
      col = '50%',
    },
    size = {
      width = '30%',
      height = 1
    },
    border = {
      style = { " ", "▄", " ", " ", " ", "▀", " ", " " },
    },
    win_options = {
      winblend = 0,
      winhighlight = "Normal:FineCmdlineNormal,FloatBorder:FineCmdlineBorder"
    },
  },
  hooks = {
    set_keymaps = function(imap, feedkeys)
      local fn = require('fine-cmdline').fn

      imap('<C-k>', function()
        if vim.fn.pumvisible() == 0 then
          fn.up_history()
        else
          feedkeys('<C-p>')
        end
      end)

      imap('<C-j>', function()
        if vim.fn.pumvisible() == 0 then
          fn.down_history()
        else
          feedkeys('<C-n>')
        end
      end)
      imap('<M-s>', '%s///gc<Left><Left><Left>')
    end
  }
})
