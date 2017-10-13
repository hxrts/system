{ pkgs }:

let
  vimrc   = pkgs.callPackage ./vimrc.nix {};
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  customRC = vimrc;
  vam = {
    knownPlugins = pkgs.vimPlugins // plugins;

    pluginDictionaries = [
      { names = [
                  "youcompleteme"
                  "vim-orgmode"
                  "vim-markdown"
                  "vim-indent-guides"
                  "gitgutter"
                  "rainbow_parentheses"
                  "surround"
                  "vim-addon-nix"
                  "vim-trailing-whitespace"
              ]; }
    { names = [
               "nginx.vim"
              ]; }
    ];
  };
}
