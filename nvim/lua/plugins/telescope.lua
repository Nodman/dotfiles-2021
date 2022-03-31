local exec = vim.api.nvim_exec
local map = require('tools').map
local Path = require('plenary.path')
local action_set = require('telescope.actions.set')
local make_entry = require('telescope.make_entry')
local os_sep = Path.path.sep
local scan = require('plenary.scandir')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local telescope = require('telescope')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local builtinTemplate = '<CMD>lua require"telescope.builtin".'

exec('hi! link TelescopeMatching WildMenu', false)

map('n', '<leader>fl', '<CMD>Telescope builtin<CR>', { silent = true })
map('n', '<leader>ff', '<CMD>Telescope find_files<CR>', { silent = true })
map('n', '<leader>fo', '<CMD>Telescope oldfiles<CR>', { silent = true })
map('n', '<leader>fF', '<CMD>Telescope git_files<CR>', { silent = true })
-- map('n', '<leader>fs', '<CMD>Telescope live_grep<CR>', { silent = true })
-- https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#basics
map('n', '<leader>fs', '<CMD>Telescope live_grep_raw<CR>', { silent = true })
map('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', { silent = true })
map('n', '<leader>fq', '<CMD>Telescope quickfix<CR>', { silent = true })
map('n', '<leader>fR', '<CMD>Telescope registers<CR>', { silent = true })
map('n', '<leader>fr', '<CMD>Telescope resume<CR>', { silent = true })
map('n', '<leader>fd', '<CMD>Telescope coc diagnostics<CR>', { silent = true })
map('n', 'gr', '<CMD>Telescope coc references<CR>', { silent = true })
map(
  'n',
  '<leader>fS',
  '<CMD>lua require"plugins.telescope".live_grep_in_folder()<CR>',
  { silent = true }
)

map(
  'n',
  '<leader>fb',
  builtinTemplate
  ..'buffers({ show_all_buffers = true })<CR>',
  { silent = true }
)
map(
  'n',
  '<leader>fw',
  builtinTemplate
    .. 'grep_string({ search = vim.fn.expand("<cword>"), only_sort_text = true })<CR>',
  { silent = true }
)
map(
  'n',
  '<leader>fW',
  builtinTemplate .. 'grep_string {  only_sort_text = true }<CR>',
  { silent = true }
)
map(
  'n',
  '<leader>fD',
  '<CMD>lua require"plugins.telescope".search_dotfiles()<CR>',
  { silent = true }
)

map(
  'n',
  '<leader>fc',
  '<CMD>lua require"plugins.telescope".coc_list(require("telescope.themes").get_dropdown({}))<CR>',
  { silent = true }
)

-- custom remapping
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_better,
        -- got used to fzf so normal mode feels a bit weired
        -- ["<esc>"] = actions.close,
        -- conficts with my insert-mode movement mappings
        ['<C-l>'] = false,
        -- send all to quickfix list
        ['<M-a>'] = actions.send_to_qflist + actions.open_qflist,
      },
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    multi_icon = ' ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
    arecibo = {
      ['selected_engine'] = 'google',
      ['url_open_command'] = 'xdg-open',
      ['show_http_headers'] = false,
      ['show_domain_icons'] = false,
    },
  },
  pickers = {
    live_grep = {
      only_sort_text = true,
    },
  },
})

-- add fuzzy search
telescope.load_extension('fzf')
telescope.load_extension('coc')
telescope.load_extension('scriptnames')
telescope.load_extension('live_grep_raw')
telescope.load_extension('arecibo')

local with_dropdown = {
  ['mru'] = true,
  ['links'] = true,
  ['commands'] = true,
  ['code_actions'] = true,
  ['line_code_actions'] = true,
  ['file_code_actions'] = true,
  ['document_symbols'] = true,
  ['workspace_symbols'] = true,
}

local M = {}

function M.live_grep_in_folder(opts)
  opts = opts or {}
  local data = {}
  scan.scan_dir(vim.loop.cwd(), {
    hidden = opts.hidden,
    only_dirs = true,
    respect_gitignore = opts.respect_gitignore,
    on_insert = function(entry)
      table.insert(data, entry .. os_sep)
    end,
  })
  table.insert(data, 1, '.' .. os_sep)

  pickers.new(opts, {
    prompt_title = 'Folders for Live Grep',
    finder = finders.new_table({
      results = data,
      entry_maker = make_entry.gen_from_file(opts),
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local dirs = {}
        local selections = current_picker:get_multi_selection()
        if vim.tbl_isempty(selections) then
          table.insert(dirs, action_state.get_selected_entry().value)
        else
          for _, selection in ipairs(selections) do
            table.insert(dirs, selection.value)
          end
        end
        actions._close(prompt_bufnr, current_picker.initial_mode == 'insert')
        require('telescope.builtin').live_grep({ search_dirs = dirs })
      end)
      return true
    end,
  }):find()
end

function M.coc_list(opts)
  opts = opts or {}
  local coc_extension = telescope.extensions.coc
  local coc_list = {}

  for k, _ in pairs(coc_extension) do
    table.insert(coc_list, { display = k, use_dropdown = with_dropdown[k] })
  end

  pickers.new(opts, {
    prompt_title = 'CoC',
    finder = finders.new_table({
      results = coc_list,
      entry_maker = function(entry)
        return {
          display = entry.display,
          ordinal = entry.display,
          picker = entry.picker,
          use_dropdown = entry.use_dropdown or false,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions._close(prompt_bufnr, true)
        if not selection.use_dropdown then
          opts = {}
        end
        coc_extension[selection.display](opts)
      end)

      return true
    end,
  }):find()
end

-- search dotfiles from anywhere
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = 'NVim dotfiles',
    cwd = '$HOME/.config/nvim/',
  })
end

return M
