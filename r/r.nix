self: super:
{
  rWrapped = super.rWrapped.override
  {
    packages = with self.rPackages;
    [
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
      Hmisc
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
      googlesheets
      tidytext
    ];
  };
}
