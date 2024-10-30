return {
	-- Shows available keybindings in a popup as you type.
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	  },
	  keys = {
	    {
	      "<leader>?",
	      function()
		require("which-key").show({ global = false })
	      end,
	      desc = "Buffer Local Keymaps (which-key)",
	    },
	  },
	},
	-- Configurable status/tabline for Vim.
	{ "itchyny/lightline.vim" },
	-- Fuzzy finder.
	{ "junegunn/fzf", build = "./install --all" },
	{ "junegunn/fzf.vim" },
	-- GBrowse
	{ "tpope/vim-rhubarb" },
	-- Better defaults.
	-- This is breaking for some reason... modifiable is off.
	-- { "liuchengxu/vim-better-default" },
    -- Improve vim.ui.select vim.ui.input
    { "stevearc/dressing.nvim" },
    -- Git stuff
    { "tpope/vim-fugitive" },
    { "kdheepak/lazygit.nvim" },
    -- Auto-adjust shiftwidth and expandtab
    { "tpope/vim-sleuth" },
}
