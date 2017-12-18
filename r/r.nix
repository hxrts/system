{ pkgs, lib, ... }:

let rWrapper = pkgs.rWrapper.override {
  packages = with pkgs.rPackages; [
    plyr
    DT
    devtools
    tidyverse
    ggplot2
    reshape2
    yaml
    optparse
    knitr
    crayon
    colorspace
    RColorBrewer
    rlist
    tidyxl
    openxlsx
    readr
    gridExtra
    scales
    lazyeval
    broom
    matrixStats
    shiny
    pacman
    curl
    openssl
    httr
    git2r
    ];
};
in [ rWrapper ]
