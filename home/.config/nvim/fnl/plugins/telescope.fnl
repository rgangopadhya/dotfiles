(import-macros {: use} :own.macros)

[
 (use :nvim-telescope/telescope.nvim
     {:dependencies [:nvim-lua/plenary.nvim
                     :nvim-lua/popup.nvim
                     :rcarriga/nvim-notify]
      :event :VeryLazy})
 (use :nvim-telescope/telescope-fzf-native.nvim
      {:build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"})
 ]
