{ config, pkgs, ... } :

{

  #--------
  # logging
  #--------

  boot.consoleLogLevel = 2;

  #---------
  # hardware
  #---------

  imports =
  [
    /home/hxrts/system/hardware/hardware.nix
    #/home/hxrts/system/r/r.nix
  ];

  boot.loader.grub.device = "nvme0n1p";
  boot.initrd.luks.devices =
  [
    {
      name = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }
  ];

  hardware.enableAllFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;  # Meltdown / Spectre patches
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;

  #------
  # clock
  #------

  time.timeZone = "America/New_York";

  #---------
  # channels
  #---------

  nix.nixPath = [ "nixpkgs=/home/hxrts/nixpkgs" "nixos-config=/home/hxrts/system/configuration.nix" ];
#  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  #system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.09;

#  system.stateVersion = "unstable";
  #system.stateVersion = "17.09";


#  "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs"
#  "nixos-config=/etc/nixos/configuration.nix"
#
  #  nixPath = [
#              "nixpkgs=https://nixos.org/channels/nixos-17.09/nixexprs.tar.xz"
#              "nixpkgs=https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz"
#              "nixos-config=/etc/nixos/configuration.nix"
#              "r-overlays=/home/hxrts/system/r/r.nix"
#    ];

  #nix.nixPath =
  #[
  #  "nixpkgs=/home/hxrts/system"
  #  "nixos-config=/etc/nixos/configuration.nix"
  #];

  #nixpkgs.overlays =
  #[
  #(import /home/hxrts/system/r/r.nix)
  #];


  system.autoUpgrade.enable      = true;
  system.copySystemConfiguration = true;  # copies to nix store path

  #-----
  # boot
  #-----

  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #--------
  # display
  #--------

  services.xserver =
  {
    enable                          = true;
    windowManager.i3.enable         = true;
    windowManager.i3.package        = pkgs.i3-gaps;
    #windowManager.i3.configFile     = /home/hxrts/.config/i3/config;
    displayManager.slim.enable      = true;
    #displayManager.slim.autoLogin   = true;
    #displayManager.slim.defaultUser = "hxrts";
    desktopManager = {
      xfce.enable                   = false;
      xterm.enable                  = false;
    };
  };

#  services.xserver.displayManager.gdm.debug = true

  #------
  # I / O
  #------

#  services.dbus.socketActivated = true;

  services.xserver.libinput =
  {
    enable                  = true;
    tapping                 = true;
    naturalScrolling        = true;
    horizontalScrolling     = true;
    disableWhileTyping      = true;
    tappingDragLock         = false;
    middleEmulation         = false;
    clickMethod             = "clickfinger";
    scrollMethod            = "twofinger";
    sendEventsMode          = "enabled";
    accelProfile            = "flat";
    accelSpeed              = "1.0";
    # calibrationMatrix       = _;
  };


  hardware.trackpoint.enable       = true;
  hardware.trackpoint.emulateWheel = true;
  hardware.trackpoint.speed        = 280;

  services.xserver.multitouch.enable       = true;
  services.xserver.multitouch.invertScroll = true;


  # xset r rate 220 40  # [delay] [rate]
  services.xserver.autoRepeatDelay    = 200;
  services.xserver.autoRepeatInterval = 30;

  services.xserver.layout     = "us";
  services.xserver.xkbOptions = "caps:swapctrl";

  i18n =
  {
    #consoleKeyMap = (pkgs.writeText "keys.map"
    #''
    #  keycode 66 = Control
    #'');
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.printing.enable            = true;
  services.printing.browsing          = true;
  services.printing.listenAddresses   = [ "*:631" ];
  services.printing.defaultShared     = true;
  services.printing.drivers           =
                                      [
                                        pkgs.gutenprint
                                        pkgs.cloud-print-connector
                                        pkgs.system_config_printer
                                        pkgs.cups-bjnp
                                        pkgs.mfcj470dw-cupswrapper
                                        pkgs.hplip
                                        pkgs.cnijfilter2
                                        pkgs.gutenprintBin
                                      ];

  services.avahi.enable               = true;
  services.avahi.publish.enable       = true;
  services.avahi.publish.userServices = true;

  #--------
  # network
  #--------

  services.nginx =
  {
    enable     = true;
    httpConfig =
    ''
      server
      {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/;
        index index.html;
        server_name test.com www.test.com;
        location /test
        {
          try_files $uri $uri/ =404;
        }
      }
    '';
    recommendedProxySettings = true;
    recommendedTlsSettings   = true;
  };

  networking.hostName              = "earth";
  networking.networkmanager.enable = true;
  networking.networkmanager.packages = [ pkgs.networkmanagerapplet ];

  networking.firewall =
  {
    enable               = true;
    allowPing            = true;
    allowedUDPPortRanges =
    [
      { from = 60000; to = 61000; }  # mosh
    ];
    allowedTCPPorts =
    [
      80   # SSH
      443  # TLS / SSL
    ];
  };

  services.openssh.enable = true;

  #---------
  # terminal
  #---------

  programs.vim.defaultEditor = true;
  programs.bash.enableCompletion = true;

  #---------
  # packages
  #---------

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = let
    moduleSys = with pkgs;
    [
      # haskell
      haskellPackages.alex
      haskellPackages.cabal-install
      haskellPackages.happy
      haskellPackages.hindent
      haskellPackages.stack
      haskellPackages.zlib
      haskellPackages.hlint
      haskellPackages.cabal2nix
      haskellPackages.hoogle
      haskellPackages.stylish-haskell
      #haskellPackages.turtle

      #haskellPackages.ghc-mod
      haskell.compiler.ghc822
      hasklig
      #hie-nix
      multi-ghc-travis

      purescript
      psc-package

      python
      pypi2nix
      gfortran
      blas
      pkgconfig
      freetype
      libpng
      #agg
      python36Packages.scipy
      python36Packages.numpy
      python36Packages.certifi
      python36Packages.chardet
      python36Packages.click
      python36Packages.decorator
      python36Packages.flask
      python36Packages.flask-cors
      python36Packages.idna
      python36Packages.itsdangerous
      python36Packages.jinja2
      python36Packages.markupsafe
      python36Packages.pytz
      python36Packages.requests
      python36Packages.six
      python36Packages.tzlocal
      python36Packages.ujson
      python36Packages.urllib3
      python36Packages.werkzeug
      #python36Packages.colorhash
      python36Packages.pandas

      nodePackages.tern

      # scripting
      closurecompiler
      graphviz
      rWrapper

      # dhall
      #dhall
      #dhall-bash
      #dhall-json
      #dhall-nix
      #dhall-text

      # printing
      cloud-print-connector
      system_config_printer
      cups-bjnp
      gutenprint
      gutenprintBin
      mfcj470dw-cupswrapper

      # window management
      dmenu
      rofi-unwrapped
      rofi-pass
      compton

      # communication
      signal-desktop
      skype
      slack
      tdesktop  # telegram
      riot-web

      # security
      browserpass
      pass
      gnupg  # needed for browserpass https://github.com/NixOS/nixpkgs/issues/33748

      # crypto
      certbot
      gnupg1
      letsencrypt
      pinentry
      solc

      # sound
      alsaLib
      alsaPlugins
      alsaTools
      alsaUtils
      apulse
      qastools
      pavucontrol
      pulseaudioFull

      # media
      audacity
      blender
      gimp
      imagemagick
      inkscape
      lame.lib
      mpd_clientlib
      picard
      rtorrent
      transmission_gtk
      vlc
      youtube-dl
      xournal

      # term
      alacritty              # rust-based terminal emulator
      at                     # scheduling
      gnome3.gnome-terminal
      automake
      binutils
      cmake
      coreutils
      dnsutils
      gcc_debug
      gnum4
      gnumake
      file
      gitAndTools.gitFull
      gitAndTools.tig
      htop
      jq
      man
      libtool
      nfs-utils
      pkgconfig
      sudo
      scrot
      tmux
      tldr
      tree
      unrar
      unzip
      (import /home/hxrts/system/vim/vim.nix)
      xclip
      zip

      # virtualization
      docker
      playonlinux
      urbit
      wine
      winetricks

      # web
      curl
      firefox
      google-chrome
      drive
      dropbox-cli
      gx
      ipfs
      mosh
      netcat
      networkmanager
      networkmanagerapplet
      sshfsFuse
      styx
      tor
      torbrowser
      wget
      wicd # command line network manager
      yarn
      xfce.thunar-dropbox-plugin

      # node
      nodejs
      nodePackages.bower
      nodePackages.grunt-cli
      nodePackages.gulp
      nodePackages.node2nix

      # txt
      ascii
      aspell
      aspellDicts.en
      emojione
      evince
      corefonts
      ghostscript
      ibus-engines.uniemoji
      libreoffice
      noto-fonts
      noto-fonts-emoji
      texlive.combined.scheme-full
      xfontsel
      xlsfonts
      xpdf

      #lightdm
      #lightdm_qt
      #lightdm_gtk_greeter

      # gnome
      lxappearance
      arc-icon-theme
      arc-theme
      font-manager
      gnome3.gnome-characters
      paper-icon-theme
      gnome3.gnome-shell
      gnome3.gnome-shell-extensions
      gnome3.gnome-tweak-tool
      gsettings-qt

      # X
      feh
      libinput
      xorg.xbacklight  # brightness controls
      xlibs.xmessage
      xorg.xorgserver
      xorg-rgb
      xorg.xf86inputlibinput
      xorg.xorgcffiles
      xorg.xorgsgmldoctools
      xorg_sys_opengl
      xorg.xinput
      xinput_calibrator

      # emacs
      emacs
      emacs-all-the-icons-fonts

      # window management
      arandr
      conky
      i3-gaps
      i3blocks-gaps
      i3lock-fancy
      polybar
      xfce.thunar

      # nix
      nix-prefetch-git
      nix-prefetch-scripts
      nix-repl
      nixops
      nox
      pypi2nix
    ];
    moduleEmacs = import /home/hxrts/system/emacs/emacs.nix pkgs;
    #moduleR     = import /home/hxrts/system/r/r.nix pkgs;
  in
    moduleSys ++
    moduleEmacs;

  programs.browserpass.enable = true;

  nixpkgs.overlays =
    [(self: super:
      {
        polybar = super.polybar.override
        {
          i3GapsSupport = true;
          mpdSupport = true;
          alsaSupport = true;
        };
      }
    )];


  #------
  # users
  #------

  users.extraUsers.hxrts =
  {
    name        = "hxrts";
    group       = "users";
    extraGroups =
    [
      "wheel"
      "networkmanager"
      "audio"
      "disk"
      "systemmd-journal"
      "nginx"
    ];
    createHome = true;
    uid        = 1000;
    home       = "/home/hxrts";
    shell      = "/run/current-system/sw/bin/bash";
  };

  security.sudo.wheelNeedsPassword = false;

  #------
  # fonts
  #------

  fonts =
  {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs;
    [
      corefonts
      emacs-all-the-icons-fonts
      emojione
      font-awesome-ttf
      iosevka
      noto-fonts
      noto-fonts-emoji
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig.defaultFonts =
    {
      monospace = [ "Iosevka Type Light" ];
      sansSerif = [ "Source Sans Pro" ];
      serif     = [ "Source Serif Pro" ];
    };
  };

}
