local map = require('tools').map
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local builtinTemplate = '<CMD>lua require"telescope.builtin".'

vim.api.nvim_exec('hi! link TelescopeMatching WildMenu', false)

-- telescope specific mappings
map('n', '<leader>ff', builtinTemplate..'find_files()<CR>', {silent = true})
map('n', '<leader>fg', builtinTemplate..'git_files()<CR>', {silent = true})
map('n', '<leader>fs', builtinTemplate..'live_grep()<CR>', {silent = true})
-- map('n', '<leader>fs', '<CMD> lua require("telescope").extensions.fzf_writer.staged_grep()<CR>', {silent = true})
map('n', '<leader>fb', builtinTemplate..'buffers({ show_all_buffers = true })<CR>', {silent = true})
map('n', '<leader>fh', builtinTemplate..'help_tags()<CR>', {silent = true})
map('n', '<leader>Tc', builtinTemplate..'colorscheme()<CR>', {silent = true})
map('n', '<leader>fq', builtinTemplate..'quickfix()<CR>', {silent = true})
map('n', '<leader>fr', builtinTemplate..'registers()<CR>', {silent = true})
map('n', '<leader>fw', builtinTemplate..'grep_string { search = vim.fn.expand("<cword>") }<CR>', {silent = true})
map('n', '<leader>fD', '<CMD>lua require"plugins.telescope".search_dotfiles()<CR>', {silent = true})

map('n', '<leader>fc', '<CMD>lua require"plugins.telescope".coc_list(require("telescope.themes").get_dropdown({}))<CR>', {silent = true})
map('n', '<leader>fd', '<CMD>Telescope coc diagnostics<CR>', {silent = true})
map('n', 'gr', '<CMD>Telescope coc references<CR>', {silent = true})

-- custom remapping
require('telescope').setup{
  defaults = {
    preview_cutoff = 1,
    file_sorter = sorters.get_fzy_sorter,

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
        -- got used to fzf so normal mode feels a bit weired
        -- ["<esc>"] = actions.close,
        -- conficts with my insert-mode movement mappings
        ["<C-l>"] = false,
        -- send all to quickfix list
        ["<M-a>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    --[[ fzf_writer = {
      minimum_grep_characters = 3,
      minimum_files_characters = 3,

      -- Disabled by default.
      -- Will probably slow down some aspects of the sorter, but can make color highlights.
      -- I will work on this more later.
      use_highlighter = true,
    }, ]]
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

-- add fuzzy search
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('coc')

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

function M.coc_list (opts)
  opts = opts or {}
  local coc_extension = require('telescope').extensions.coc
  local coc_list = {}

  for k,_ in pairs(coc_extension) do
    table.insert(coc_list, { display = k, use_dropdown = with_dropdown[k] })
  end

  pickers.new(opts, {
    prompt_title = 'CoC',
    finder = finders.new_table {
      results = coc_list,
      entry_maker = function(entry)
        return {
          display = entry.display,
          ordinal = entry.display,
          picker = entry.picker,
          use_dropdown = entry.use_dropdown or false
        }
      end
    },
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
  require("telescope.builtin").find_files({
    prompt_title = "NVim dotfiles",
    cwd = "$HOME/.config/nvim/",
  })
end

return M
