{ pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {

  "nginx.vim" = buildVimPlugin {
    name = "nginx.vim";
    src = fetchgit {
      url = "https://github.com/chr4/nginx.vim";
      rev = "52453c0a6f745feaa66760bc23e88b72d67cb18b";
      sha256 = "0i7xyad40yirfg4a2lj9b94dd5sx6qzyzn2zx2qkj5inz02n0zky";
    };
    dependencies = [];
   };
}
