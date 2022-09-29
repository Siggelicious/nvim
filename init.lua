-- Keymaps.
local keymaps = {
	[{ 'i' }] = {
		['jk'] = '<esc>',
		['<C-h>'] = '<left>',
		['<C-j>'] = '<down>',
		['<C-k>'] = '<up>',
		['<C-l>'] = '<right>',
		['<C-w>'] = '<C-o>w',
		['<C-e>'] = '<C-o>e',
		['<C-b>'] = '<C-o>b',
		['<C-u>'] = '<C-o><C-u>',
		['<C-d>'] = '<C-o><C-d>'
	},
	[{ 'n' }] = {
		['<S-h>'] = ':tabprevious<CR>',
		['<S-j>'] = ':tablast<CR>',
		['<S-k>'] = ':tabfirst<CR>',
		['<S-l>'] = ':tabnext<CR>',
		['<C-h>'] = '<C-w>h',
		['<C-j>'] = '<C-w>j',
		['<C-k>'] = '<C-w>k',
		['<C-l>'] = '<C-w>l',
		['<A-h>'] = ':bp<CR>',
		['<A-j>'] = ':bl<CR>',
		['<A-k>'] = ':bf<CR>',
		['<A-l>'] = ':bn<CR>',
	}
}

for modes, maps in pairs(keymaps) do
    for left, right in pairs(maps) do
        vim.keymap.set(modes, left, right, { silent=true })
    end
end

-- Editor preferences.
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Plugins.
require('packer').startup(function(use) 
	use 'wbthomason/packer.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'dcampos/nvim-snippy'
	use 'dcampos/cmp-snippy'
	use 'folke/tokyonight.nvim'
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = {
			'kyazdani42/nvim-web-devicons',
			opt = true 
		}
	}
	use {
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('trouble').setup {}
		end
	}
	use {
		'windwp/nvim-autopairs',
		config = function() 
			require('nvim-autopairs').setup {} 
		end
	}
end)

-- Autocomplete setup.
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<S-tab>'] = cmp.mapping.select_prev_item(),
		['<tab>'] = cmp.mapping.select_next_item(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),	
	sources = cmp.config.sources({
		{ name = 'nvim_lsp'},
		{ name = 'snippy' },	
		{ name = 'path' }
	})
})

-- LSP setup.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['pyright'].setup { capabilities = capabilities }
require('lspconfig')['rust_analyzer'].setup { capabilities = capabilities }
require('lspconfig')['clangd'].setup { capabilities = capabilities }

-- theme setup.
require('tokyonight').setup({
	style = 'night'
})
require('lualine').setup {
	options = {
		theme = 'tokyonight'
	}
}
vim.cmd[[colorscheme tokyonight]]
