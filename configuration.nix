{ config, pkgs, ... } : {

  #---------
  # hardware
  #---------

  imports = [ /home/hxrts/system/hardware/hardware.nix ];

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

  #------
  # clock
  #------

  time.timeZone = "America/New_York";

  #---------
  # channels
  #---------

  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.09;

  system.stateVersion = "unstable";
  # system.stateVersion = "17.09";

  system.autoUpgrade.enable      = true;
  system.copySystemConfiguration = true;

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
    enable                              = true;
    desktopManager.gnome3.enable        = true;
    displayManager.gdm.enable           = true;
    displayManager.gdm.autoLogin.enable = true;
    displayManager.gdm.autoLogin.user   = "hxrts";
  };

  #------
  # I / O
  #------

  services.dbus.socketActivated = true;

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
  services.xserver.xkbOptions = "caps:ctrl";

  i18n =
  {
    consoleFont   = "Lat2-Terminus16";
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
        root /var/www/researchtactics.com;
        index index.html;
        server_name researchtactics.com www.researchtactics.com;
        location /
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
    enable            = true;
    allowPing         = true;
    allowedUDPPorts   = [ 80 8000 ];
    allowedTCPPorts   = [ 80 443 8000 ];
  };

  services.openssh.enable = true;

  programs.mtr.enable = true;

  #---------
  # terminal
  #---------

  environment.sessionVariables = { EDITOR = "vim"; };

  programs.bash.enableCompletion = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  #---------
  # packages
  #---------

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = let
    moduleSys = with pkgs;
    [
      (haskell.packages.ghc802.ghcWithHoogle (self :
      [
        self.ghc
        self.hindent
        self.xmonad-contrib
        self.xmonad-extras
        self.xmonad
        self.xmobar
        self.alex
        self.happy
        self.hlint
        self.zlib
        self.stack
        self.cabal-install
        self.cabal2nix
        self.packdeps
        self.stylish-haskell
        self.pandoc
        self.ghc-mod
        self.lens
      ]))

      # haskell
      hasklig
      multi-ghc-travis

      # printing
      cloud-print-connector
      system_config_printer
      cups-bjnp
      gutenprint
      gutenprintBin
      mfcj470dw-cupswrapper

      # scripting
      closurecompiler
      graphviz
      purescript
      psc-package
      python36Packages.xcffib
      rWrapper

      # navigation
      albert
      dmenu
      xmonad-with-packages
      xmonad_log_applet_gnome2

      # communication
      #signal-messenger
      skype
      slack

      # security
      browserpass
      pass

      # crypto
      certbot
      gnupg1
      letsencrypt
      pinentry
      solc

      # media
      audacity
      blender
      gimp
      imagemagick
      inkscape
      krita
      lame.lib
      picard
      rtorrent
      transmission_gtk
      vlc
      youtube-dl
      xournal

      # term
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
      tmux
      tldr
      tree
      unrar
      unzip
      #vimHugeX
      (import /home/hxrts/system/vim/vim.nix)
      xclip

      # emulation
      playonlinux
      travis
      urbit
      wine
      winetricks

      # web
      chrome-gnome-shell
      curl
      google-chrome
      drive
      dropbox-cli
      gx
      ipfs
      mosh
      netcat
      nodejs
      npm2nix
      selenium-server-standalone
      sshfsFuse
      styx
      tor
      torbrowser
      wget
      yarn
      xfce.thunar-dropbox-plugin
      #uget
      #openssl
      #zlib.dev
      #zlib.out

      # txt
      ascii
      aspell
      emojione
      corefonts
      ghostscript
      ibus-engines.uniemoji
      libreoffice
      noto-fonts
      noto-fonts-emoji
      xfontsel
      xlsfonts
      xpdf

      # gnome
      arc-icon-theme
      arc-theme
      evince
      font-manager
      gnome2.libgnome
      gnome3.gdm
      gnome3.gnome-characters
      gnome3.gnome-nettool
      gnome3.gnome-screenshot
      gnome3.gnome_shell
      gnome3.gnome-shell-extensions
	    gnome3.gnome-software
      gnome3.networkmanagerapplet
      gnome3.gpaste
      gtk-engine-murrine
      gtk_engines
      paper-icon-theme
      rhythmbox

      # nix
      nix-prefetch-git
      nix-prefetch-scripts
      nix-repl
      nixops
      nox

      # emacs
      emacs
      emacs-all-the-icons-fonts

      # X
      libinput
      xlibs.xmessage
      xorg.xorgserver
      xorg-rgb
      xorg.xf86inputlibinput
      xorg.xorgcffiles
      xorg.xorgsgmldoctools
      xorg_sys_opengl
      xorg.xinput
      xinput_calibrator
    ];
    moduleEmacs   = import /home/hxrts/system/emacs/emacs.nix pkgs;
    moduleR       = import /home/hxrts/system/r/r.nix         pkgs;
    #moduleCurl    = import /home/hxrts/system/curl/curl.nix   pkgs;
  in
    moduleSys ++ moduleEmacs ++ moduleR; # ++ moduleCurl ++ moduleVim ++


  #------
  # users
  #------

  users.extraUsers.hxrts =
  {
    name  = "hxrts";
    group = "users";
    extraGroups =
    [
      "wheel"
      "networkmanager"
      "disk"
      "systemmd-journal"
    ];
    createHome = true;
    uid   = 1000;
    home  = "/home/hxrts";
    shell = "/run/current-system/sw/bin/bash";
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
      iosevka
      emacs-all-the-icons-fonts
      emojione
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

  #----
  # end
  #----

}
