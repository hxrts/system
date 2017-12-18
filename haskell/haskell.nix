{
  packageOverrides = super: let self = super.pkgs; in
  {
    myHaskellEnv = self.haskellPackages.ghcWithHoogle
                     (haskellPackages: with haskellPackages; [
                       # libraries
                       arrows async cgi criterion
                       # tools
                       cabal-install haskintex
                     ]);
  };
}




{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    haskellPackages.cabal-install

    (haskell.packages.ghc802.ghcWithPackages (self : [
      self.hlint
      self.ghc-mod
    ]))

    cabal-install
    ghc
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    haskellPackages.xmonad
    haskellPackages.xmobar
    hasklig
    stack


    gcc
    binutils # for the ar executable
    haskellPackages.alex
    haskellPackages.happy
    haskellPackages.zlib
    haskellPackages.stack

    haskellPackages.cabal2nix
    haskellPackages.hoogle
    haskellPackages.packdeps
    haskellPackages.stylish-haskell
    multi-ghc-travis

    # # for the ihaskell-notebook executable, used with
    # #
    # # stack exec -- ihaskell-notebook
    # #
    # # The idea is to use this command when I want to run ihaskell
    # # with extra packages (either mine or others) and to use
    # # `servies.ihaskell.enable, which will always start first
    # # and take port 8888, when I want to use vanilla ihaskell.
    # ihaskell
  ];

  # services.ihaskell.enable = true;
}
