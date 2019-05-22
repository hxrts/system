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

  powerManagement.enable = true;

  #------
  # clock
  #------

  time.timeZone = "America/New_York";
  #time.timeZone = "CET";

  #------
  # sound
  #------

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;

  #---------
  # channels
  #---------

  #nix.nixPath = [ "nixpkgs=/home/hxrts/nixpkgs" "nixos-config=/home/hxrts/system/configuration.nix" ];
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  #system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.09;

  system.stateVersion = "unstable";
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

  #nixpkgs.overlays = [(import /home/hxrts/system/r/r.nix)];

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

  #------
  # I / O
  #------

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


  hardware.trackpoint = {
    enable       = true;
    emulateWheel = true;
    speed        = 280;
    sensitivity  = 140;
  };

  services.xserver.multitouch.enable       = true;
  services.xserver.multitouch.invertScroll = true;


  # xset r rate 220 40  # [delay] [rate]
  services.xserver.autoRepeatDelay    = 200;
  services.xserver.autoRepeatInterval = 30;

  services.xserver.layout     = "us";
  services.xserver.xkbOptions = "caps:swapctrl";

  i18n =
  {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.printing = {
    enable            = true;
    browsing          = true;
    listenAddresses   = [ "*:631" ];
    defaultShared     = true;
    drivers           =
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
  };

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

  nixpkgs.config.permittedInsecurePackages = [
    "samba-3.6.25"
  ];

  environment.systemPackages = let
    moduleSys = with pkgs;
    [
      closurecompiler
      graphviz
      rWrapper

      cabal2nix

      # printing
      cloud-print-connector
      system_config_printer
      cups-bjnp
      gutenprint
      gutenprintBin
      mfcj470dw-cupswrapper

      # communication
      #patchwork
      signal-desktop
      skype
      slack
      tdesktop  # telegram
      zoom-us

      # security
      bitwarden-cli
      browserpass
      keybase
      keybase-gui
      kbfs
      pass
      passff-host
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
      ffmpeg-full
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
      eternal-terminal
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
      pijul
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
      #playonlinux
      wine
      winetricks
      urbit

      # storage
      ipfs
      fuse
      s3fs    # S3 fuse
      s3cmd   # S3 command line tools
      zeronet

      # web
      curl
      firefox
      google-chrome
      drive
      dropbox-cli
      gx
      mosh
      netcat
      networkmanager
      sshfsFuse
      styx
      tor
      torbrowser
      wget

      xfce.gvfs
      gvfs
      samba

      # node
      nodejs-10_x
      #nodePackages.bower
      #nodePackages.grunt-cli
      #nodePackages.gulp
      nodePackages.node2nix
      #nodePackages.webpack
      yarn
      yarn2nix

      # txt
      ascii
      aspell
      aspellDicts.en
      emojione
      evince  # pdf reader
      corefonts
      ghostscript
      ibus-engines.uniemoji
      libreoffice
      noto-fonts
      noto-fonts-emoji
      #texlive.combined.scheme-full
      xfontsel
      xlsfonts
      xpdf

      # emacs
      emacs
      emacs-all-the-icons-fonts

      # gnome
      lxappearance
      arc-icon-theme
      arc-theme
      font-manager
      gnome3.gnome-characters
      paper-icon-theme
      #gnome3.gnome-shell
      #gnome3.gnome-shell-extensions
      #gnome3.gnome-tweak-tool
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

      # notifications
      dunst

      #lightdm
      #lightdm_qt
      #lightdm_gtk_greeter

      # window & file management
      arandr
      conky
      compton
      dmenu
      #gnome2.pango  # i3 text rendering
      #gnome3.nautilus
      i3-gaps
      i3blocks-gaps
      i3lock-fancy
      polybar
      rofi-unwrapped
      rofi-pass

      # nix
      nix-prefetch-git
      nix-prefetch-scripts
      nixops
      nox
      #haskellPackages.nix-derivation
      #haskellPackages.nix-diff
    ];
    moduleEmacs = import /home/hxrts/system/emacs/emacs.nix pkgs;
    #moduleR     = import /home/hxrts/system/r/r.nix pkgs;
  in
    moduleSys ++
    moduleEmacs;

  programs.browserpass.enable = true;
  #services.gnome3.sushi.enable = true;

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

  nixpkgs.config.packageOverrides = pkgs: {
    xfce = pkgs.xfce // {
      gvfs = pkgs.gvfs;
    };
  };

  # fix trackpad scroll issue on wakeup
  powerManagement.resumeCommands = ''
    sudo modprobe -r psmouse && sudo modprobe psmouse
  '';

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

  services.keybase.enable = true;
  services.kbfs.enable = true;

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
