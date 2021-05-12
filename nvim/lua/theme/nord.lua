local exec = vim.api.nvim_exec

exec('colorscheme nord', false)

-- fix for telescope match highlight
exec('hi QuickFixLine guibg=#81A1C1', false)
exec('hi CursorLineNr guifg=#81A1C1', false)
-- because of weired looking braces in lsp popups
-- exec('hi Normal guibg=NONE', false)
