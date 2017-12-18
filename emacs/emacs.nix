{ pkgs, lib, ... }:

let emacs = pkgs.emacs.override {
  withGTK3 = true;
  withGTK2 = false;
};
in [ emacs ]
