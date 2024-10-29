(import-macros {: use} :own.macros)
(use :Tsuzat/NeoSolarized.nvim {
     :lazy false ;make sure we load this during startup if it is your main colorscheme
     :priority 1000 ; make sure to load this before all the other start plugins
     :config #(vim.cmd "colorscheme NeoSolarized")
})
