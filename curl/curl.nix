{ pkgs, lib, ... }:

let curl = pkgs.curl.override {
  zlibSupport   = true;
  sslSupport    = true;
};
in [ curl ]
