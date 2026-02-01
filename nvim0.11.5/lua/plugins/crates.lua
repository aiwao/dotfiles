return {
  "saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	requires = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
}
