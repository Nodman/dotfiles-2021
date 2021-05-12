local map = require('tools').map

local options = { noremap = false }


map("n", "<leader>cc", "<Plug>kommentary_line_default", options)
map("n", "<leader>c", "<Plug>kommentary_motion_default", options)
map("v", "<leader>c", "<Plug>kommentary_visual_default", options)
