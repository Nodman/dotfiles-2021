local M = require'packer'.startup(function(use)

  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colour scheme
  use 'christianchiarulli/nvcode-color-schemes.vim'

  use 'wakatime/vim-wakatime'

  --until telescope live grep freezes
  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = function ()
      vim.cmd([[
        function! RipgrepFzf(query, fullscreen)
          let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
          let initial_command = printf(command_fmt, shellescape(a:query))
          let reload_command = printf(command_fmt, '{q}')
          let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
          call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
        endfunction

        command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
      ]])
    end
  }

  -- fzf alternative
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      -- { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
    },
    config = function()
      require'plugins/telescope'
    end
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- tree sitter provider
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require'plugins/treesitter'
    end
  }
  -- commenting
  use {
    'b3nj5m1n/kommentary',
    config = function ()
      require'plugins/kommentary'
    end
  }

  -- JSON tools
  use {
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json' }
  }

  -- git signs
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require'plugins/git-signs'
    end
  }

  -- git links
  use {
    'ruifm/gitlinker.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require'gitlinker'.setup({
        opts = {
          -- callback for what to do with the url
          action_callback = require"gitlinker.actions".open_in_browser,
          mappings = "<leader>gb"
        }
      })
    end
  }

  -- git diff
  use { 'sindrets/diffview.nvim' }

  -- auto pairs
  use 'jiangmiao/auto-pairs'

  -- vim-surround
  use 'tpope/vim-surround'

  -- debugging
  use {
    'mfussenegger/nvim-dap',
    requires = {
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'rcarriga/nvim-dap-ui' },
    },
    config = function ()
      require'plugins/nvim-dap'
    end,
    cmd = 'DapEnable',
  }

  -- better quickfix
  use 'kevinhwang91/nvim-bqf'

  -- colorize color values
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup {
        'css';
        'scss';
        'javascript';
        'javascriptreact';
        'typescript';
        'typescriptreact';
      }
    end,
    ft = {
      'css';
      'scss';
      'javascript';
      'javascriptreact';
      'typescript';
      'typescriptreact';
    }
  }

  -- completion and LSP
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    requires = {
     { 'fannheyward/telescope-coc.nvim' }
    },
    config = function ()
      require'plugins/coc'
    end
  }

  -- neovim LSP
  --[[ use {
    'neovim/nvim-lspconfig',
    ft = {
      'lua',
    },
  } ]]

  -- LSP installer
  -- use 'kabouzeid/nvim-lspinstall'

  -- completion
  -- use 'nvim-lua/completion-nvim'

  -- spell check
  use {
    'kamykn/spelunker.vim',
    config = function ()
      require'plugins/spelunker'
    end,
    ft = {
      'css';
      'scss';
      'javascript';
      'javascriptreact';
      'typescript';
      'typescriptreact';
      'markdown',
      'lua',
      'json',
    }
  }

  -- lsp utils
  -- use 'glepnir/lspsaga.nvim'

  -- file explorer
  --[[ use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
    },
  } ]]

end)

return M
