local exec = vim.api.nvim_exec
local map = require'tools'.map
local createAugroup = require'tools'.createAugroup

vim.g.coc_global_extensions = {
  'coc-explorer',
  'coc-json',
  'coc-eslint',
  'coc-tsserver',
  'coc-cssmodules',
  'coc-stylelintplus',
  'coc-prettier',
  'coc-lua',
  'coc-jest',
}

local fileChildTemplate = {
 '[git | 2]',
 '[selection | clip | 1]',
 '[indent]',
 '[icon | 1] ',
 '[diagnosticError & 1]',
 '[filename omitCenter 1]',
 '[modified]',
 '[readonly]',
 '[linkIcon & 1]',
 '[link growRight 1 omitCenter 5]',
}

vim.g.coc_explorer_global_presets = {
  floating = {
    ['position'] = 'floating',
    ['floating-width'] = 70,
    ['floating-height'] = -1,
    ['file-root-template'] = '[icon] [root]',
    ['file-child-template'] = table.concat(fileChildTemplate),
  },
}

-- adjust highlight
exec('hi! link CocErrorHighlight healthError', false)
exec('hi! link CocUnusedHighlight CocExplorerBufferHidden', false)
exec('hi! link CocErrorFloat NormalFloat', false)
exec('hi! link CocWarningHighlight healthWarning', false)
exec('hi! link CocExplorerBookmarkLine PmenuSel', false)
exec('hi! link CocExplorerSelectUI MarkdownBold', false)
exec('hi CocHoverRange guifg=NONE guibg=NONE gui=underline', false)
exec('hi LspDiagnosticsUnderlineError gui=undercurl', false)

-- commands
exec([[
  command! -nargs=0 Format :call CocAction('format')
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
  command! -nargs=0 OrgImports :call CocAction('runCommand', 'editor.action.organizeImport')
  command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
  command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
  command! JestInit :call CocAction('runCommand', 'jest.init')
]], false)

-- TODO rewrite to lua

-- key maps
local silentRemap = { silent = true, noremap = false }

map('n', '<leader>e', '<CMD>CocCommand explorer  --preset floating --sources file+<CR>', silentRemap)
map('n', '<leader>bb', '<CMD>CocCommand explorer  --preset floating --sources buffer+<CR>', silentRemap)

map('n', '<leader>te', '<CMD>call CocAction("runCommand", "jest.singleTest")<CR>')

map('n', 'g[', '<Plug>(coc-diagnostic-prev)', silentRemap)
map('n', 'g]', '<Plug>(coc-diagnostic-next)', silentRemap)
map('n', 'ge', '<Plug>(coc-diagnostic-next)', silentRemap)

map('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : ""', { silent = true, expr = true })
map('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : ""', { silent = true, expr = true })
map('i', '<C-f>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<Right>"', { silent = true, expr = true })
map('i', '<C-b>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<Left>"', { silent = true, expr = true })

-- map('n', 'K', '<CMD>call <SID>show_documentation()<CR>', { silent = true })

map('n', 'gd', '<Plug>(coc-definition)', silentRemap)
map('n', 'gy', '<Plug>(coc-type-definition)', silentRemap)
map('n', 'gi', '<Plug>(coc-implementation)', silentRemap)
-- in favor of telescope coc action
-- map('n', 'gr', '<Plug>(coc-references)', silentRemap)

map('v', '<tab>', '<Plug>(coc-format-selected)', silentRemap)

map('n', 'gh', '<CMD>call CocActionAsync("doHover")<CR>', silentRemap)

map('n', '<leader>ca', '<Plug>(coc-codeaction)', silentRemap)

map('n', '<leader>bf', '<CMD>Format<CR>', silentRemap)

-- events
createAugroup({
  { 'User', 'CocJumpPlaceholder', 'call CocActionAsync("showSignatureHelp")' }
}, 'coc_user')

