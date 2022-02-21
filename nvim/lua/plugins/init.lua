local M = require'packer'.startup(function(use)

  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colour scheme
  use 'christianchiarulli/nvcode-color-schemes.vim'

  -- fzf alternative
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
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
  use {
    'sindrets/diffview.nvim',
    config = function ()
      require'plugins/diffview'
    end
  }

  -- auto pairs
  use 'jiangmiao/auto-pairs'

  -- vim-surround
  use 'tpope/vim-surround'

  -- debugging
  use {
    'mfussenegger/nvim-dap',
    requires = {
      { 'rcarriga/nvim-dap-ui' },
    },
    config = function ()
      require'plugins/nvim-dap'
    end,
    cmd = 'DapEnable',
  }

  --[[ use {
    'theHamsta/nvim-dap-virtual-text'
  } ]]

  -- colorize color values
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup {
        'lua',
        'css';
        'scss';
        'javascript';
        'javascriptreact';
        'typescript';
        'typescriptreact';
      }
    end,
    ft = {
      'lua',
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

  use {
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' },
    },
    config = function ()
      require'plugins/fine-cmd'
    end
  }

  use 'wakatime/vim-wakatime'

  use 'tpope/vim-obsession'

end)

return M
