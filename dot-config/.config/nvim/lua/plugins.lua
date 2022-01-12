local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use, use_rocks)
    use 'wbthomason/packer.nvim'
    -- === Language agnostic editing plugins ===
    use {opt = false,'jiangmiao/auto-pairs'} -- auto-close brackets plugin
    use {opt = false,'alvan/vim-closetag'} -- auto close html tags
    use {opt = false,'tpope/vim-surround'} -- cs<surrounding1><surrounding2> ds<surrounding1>
    use {opt = false,'b3nj5m1n/kommentary'} -- visual select + gc
    use {opt = false,'kshenoy/vim-signature'} -- Display visual marks (`ma`) in separate column
    use {opt = false,'SirVer/ultisnips'} -- :UltiSnips...
    use {opt = false,'wellle/targets.vim'} -- Additional text objects: e.g. inside *, inside comma-separated list etc.

    use {opt = false,'prettier/vim-prettier'} -- :Prettier
    use {opt = false,'ggandor/lightspeed.nvim'}
    use {opt = false,'tpope/vim-repeat'} -- zero-config, allows to repeat complex commands
    use {opt = false,'AndrewRadev/splitjoin.vim'}
    use {opt = false,'matze/vim-move'}
    use {opt = false,'sk1418/HowMuch'} -- https://github.com/sk1418/HowMuch
    use {opt = false,'ThePrimeagen/harpoon'} 
    use {opt = false,'L3MON4D3/LuaSnip'}
    use {opt = false,'saadparwaiz1/cmp_luasnip'}

    -- === Vim utilities ===
    use {opt = false,'xolox/vim-session'} -- Provides OpenSession and SaveSession
    use {opt = false,'tversteeg/registers.nvim'} -- register preview

    -- === Git ===
    use {opt = false,'tpope/vim-fugitive'} -- :G
    use {opt = false,'mhinz/vim-signify'} -- Enable git changes to be shown in sign column

    -- === UI === --
    use {opt = false,'junegunn/goyo.vim'} -- distractionless mode
    use {opt = false,'junegunn/limelight.vim'} -- highlight only current paragraph
    use {opt = false,'hoob3rt/lualine.nvim'}
    -- use {'glepnir/galaxyline.nvim'} -- someday.. you will write your own
    use {opt = false,'karb94/neoscroll.nvim'} -- smooth scroll
    use {opt = false,'edluffy/specs.nvim'} -- cursor jump landing visualization 
    use {opt = false,'stevearc/aerial.nvim'} -- sideways navigating the file on lsp tags
    use {opt = false,'kyazdani42/nvim-tree.lua'} --File explorer
    use {opt = false, 'dbeniamine/cheat.sh-vim'} -- Cheat sheet plugin
    use {opt = false, 'azabiong/vim-highlighter'} -- Highlight words on a whim

    -- Looks amazing but does not work for now... Colors are not applied
    -- use {'nanozuki/tabby.nvim'} -- tabline

    -- Now, I do not use this as vimwiki, but does nice markdown 
    -- per-line formatting (highlights `` and hides tildas itself)
    use {opt = false,'vimwiki/vimwiki'}

    -- === Colorschemes === --
    use {opt = false,'morhetz/gruvbox'}
    use {opt = false,'savq/melange'}

    -- === TMUX === --
    use {opt = false,'christoomey/vim-tmux-navigator'} -- Allows to use <C-hjkl> to move to/from tmux panes
    use {opt = false,'dhruvasagar/vim-zoom'} -- Allows to mimic tmux <pref>Z with <C-W>m
    use {opt = false,'sjl/vitality.vim'} -- Restore FocusGained, FocusLost

    -- === LSP === 
    use {opt = false,'neovim/nvim-lspconfig'}
    use {opt = false,'onsails/diaglist.nvim'}
    use {opt = false,disable=false,'glepnir/lspsaga.nvim'}
    -- completion core and completion sources
    use {opt = false,'hrsh7th/nvim-cmp'}
    use {opt = false,'hrsh7th/cmp-buffer'}   
    use {opt = false,'hrsh7th/cmp-path'}   
    use {opt = false,'hrsh7th/cmp-nvim-lua'}   
    use {opt = false,'hrsh7th/cmp-nvim-lsp'}   
    --[[ use {
     disable = true,
     "folke/trouble.nvim",
     requires = "kyazdani42/nvim-web-devicons"
    } ]]

    -- === Treesitter ===
    use {opt = false,'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {opt = false,'p00f/nvim-ts-rainbow'}

    -- === Telescope === 
    use {opt = false,'nvim-telescope/telescope.nvim'}
    use {opt = false,'nvim-telescope/telescope-fzy-native.nvim'}

    -- === Language specific ===
    use {opt = false,'hashivim/vim-terraform'}
    use {opt = false,'martingms/vipsql'} --  <leader>po

    -- === DevOps specific ===
    use {opt = false,'chipsenkbeil/distant.nvim'}

    -- === Plugin \ Lua development ===
    use {opt = false,disable=false,'tjdevries/colorbuddy.nvim'}
    use_rocks 'http'
    use_rocks 'lua-cjson'

    -- === Dependencies ===
    use {opt = false,'tami5/sqlite.lua'}
    use {opt = false,'ryanoasis/vim-devicons'}
    use {opt = false,'kyazdani42/nvim-web-devicons'}
    use {opt = false,'nvim-lua/popup.nvim'}
    use {opt = false,'nvim-lua/plenary.nvim'}
    use {opt = false,'xolox/vim-misc' }
    use {opt = false,'onsails/lspkind-nvim'}
end)
