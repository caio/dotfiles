return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		requires = { 'nvim-treesitter/nvim-treesitter-refactor' },
		run = ':TSUpdate',
		config = [[require('config.treesitter')]]
	}
end)
