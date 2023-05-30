-- plugin: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- bootstrap packer if it's not installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
end

-- resync packer when this file is changed
vim.cmd [[
  augroup packer_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- protected call packer require to avoid first-time errors
local ok, packer = pcall(require, 'packer')
if not ok then
	return
end

-- configure packer
packer.init({
	-- use a floating window for packer
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	-- profile packages
	profile = {
		enable = true,
		threshold = 0,  -- show packages taking longer than these many milliseconds
	},
	autoremove = true,
})






-- startup packer and install packages
packer.startup(function(use)
  ----------
  -- CORE
  ----------
  use 'wbthomason/packer.nvim'  -- packer manage packer
  use { "nvim-lua/plenary.nvim", module = "plenary" }



  ---------------
  -- UTILITIES
  ---------------

  -- performance
  use {
    'lewis6991/impatient.nvim',
    config = function() require("config.impatient") end,
  }
  -- other
  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function() require("config.which-key") end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufWinEnter",
    config = function() require("config.indentblankline") end,
  }
	use {
    "lewis6991/gitsigns.nvim",  -- show git change status
    config = function() require("config.gitsigns") end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function() require("config.comment") end,
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("config.todocomments") end,
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function() require("config.telescope") end,
  }
  use {
    'jiaoshijie/undotree',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("config.undotree") end,
  }
  -- fast motions
  use {  -- hop motions
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    cmd = { "HopWord", "HopLine", "HopPattern", "HopAnywhere" },
    config = function() require("config.hop") end,
  }
  -- consider substituting lightspeed with leap
  use {  -- futurevision sneak
    "ggandor/lightspeed.nvim",
    -- keys = { "s", "S", "f", "F", "t", "T", "gs", "gS" },
    config = function() require("config.lightspeed") end,
  }
  -- tmux integration
  use {
    "aserowy/tmux.nvim",
    config = function() require("config.tmux") end,
  }
  -- show color of color codes
  -- use {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function() require("config.colorizer") end,
  -- }
  use {
    'uga-rosa/ccc.nvim',
    as = 'ccc',
    config = function() require("config.ccc") end,
  }
  -- highlight ranges in commandline
  use {
    'winston0410/range-highlight.nvim',
    requires = 'winston0410/cmd-parser.nvim',
    config = function() require("config.rangehighlight") end
  }


  --------------
  -- LITERATE
  --------------
  -- markdown, latex, bib, and other technical document writing
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle" },
  })



  ---------
  -- LSP
  ---------
  -- treesitter, lsp, lsp package management, and other language support
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function() require("config.lsp.treesitter") end,
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function() require("config.autotag") end,
  }
  use {
    "folke/lsp-colors.nvim",
    config = function() require("config.lsp.lsp-colors") end,
  }
  use {
    "williamboman/mason.nvim",
    config = function() require("config.lsp.mason") end,
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    requires = "williamboman/mason.nvim",
    config = function()
      require("config.lsp.mason")
      require("config.lsp.mason-lspconfig")
    end,
  }
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "folke/lsp-colors.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() require("config.lsp.lsp-config") end,
  }
  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require("config.lsp.trouble") end,
  }


  --------------------
  -- USER INTERFACE
  --------------------
  -- themes, icons, and other looks
  use {
    "catppuccin/nvim",
    as = "catppuccin",
  }

  use {
    "loctvl842/monokai-pro.nvim",
    as = 'monokai-pro',
  }

  use {
    "ellisonleao/gruvbox.nvim",
    as = 'gruvbox',
  }

  use {
    'shaunsingh/solarized.nvim',
    as = 'solarized',
  }

  use {
    'NLKNguyen/papercolor-theme',
    as = 'papercolor',
  }

  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function() require("config.devicons") end,
  }
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("config.bufferline") end,
  }


  -- automatically sync packages after bootstrap
  if packer_bootstrap then
    require('packer').sync()
  end
end)
