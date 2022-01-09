local map = require('tools').map

map('n', ';', '<CMD>lua require("fine-cmdline").open()<CR>', {silent = true})

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
  },
  popup = {
    relative = "editor",
    position = {
      row = '10%',
      col = '50%',
    },
    size = {
      width = '40%',
      height = 1
    },
    border = {
      -- style = { " ", " ", " ", " ", " ", "─", " ", " " },
      style = "rounded",
    },
    win_options = {
      winblend = 20,
      winhighlight = "Normal:Normal,FloatBorder:Operator"
    },
  },
  hooks = {
    before_mount = function(input)
      -- Prompt can influence the completion engine.
      -- This is your chance to change it to something that works for you
      -- input.input_props.prompt = ': '
    end,
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
          fn.up_history()
        else
          feedkeys('<C-n>')
        end
      end)
      imap('<M-s>', '%s///gc<Left><Left><Left>')
    end
  }
})
