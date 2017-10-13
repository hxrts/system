{ pkgs, lib, ... }:

let
 emacs = (pkgs.emacs.override {
    # Use gtk3 instead of the default gtk2
    withGTK3 = true;
    withGTK2 = false;
  });
in [
  emacs
]

