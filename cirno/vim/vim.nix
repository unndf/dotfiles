with import <nixpkgs> {};

pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [ syntastic  vim-airline  vim-fugitive molokai ultisnips ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ vim-javacomplete2 ];
        # To automatically load a plugin when opening a filetype, add vimrc lines like:
        # autocmd FileType php :packadd phpCompletion
      };
      vimrcConfig.customRC = builtins.readFile ./.vimrc;
}
