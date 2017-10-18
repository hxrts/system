{ config, pkgs, ... } : {

  #---------
  # hardware
  #---------

  imports =
    [
      /home/hxrts/system/nixos/hardware-configuration.nix
    ];

  #---------
  # channels
  #---------

  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  system.stateVersion = "unstable";

  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-17.09;
  # system.stateVersion = "17.09";

  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;

  #-----
  # boot
  #-----

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #-------
  # drives
  #-------

  boot.loader.grub.device = "nvme0n1p";
  boot.initrd.luks.devices = [
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

  #--
  # X
  #--

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  #services.xserver.desktopManager.gdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;


  #------
  # I / O
  #------

  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = true;
  services.xserver.libinput.clickMethod = "clickfinger";
  services.xserver.libinput.naturalScrolling = true;
  services.xserver.libinput.tappingDragLock = false;
  services.xserver.libinput.horizontalScrolling = true;
  services.xserver.libinput.scrollMethod = "twofinger";
  services.xserver.libinput.sendEventsMode = "enabled";


  services.xserver.libinput.accelSpeed = "1.2";
  services.xserver.libinput.accelProfile = "adaptive";
  #services.xserver.libinput.accelProfile = "flat";

  #services.xserver.libinput.calibrationMatrix

#  services.xserver.synaptics = {
#    enable = true;
#    tapButtons = true;
#    twoFingerScroll = true;
#    vertEdgeScroll = false;
#    vertTwoFingerScroll = true;
#    horizTwoFingerScroll = true;
#    palmDetect = false;
#    minSpeed = "0.6";
#    maxSpeed = "1.5";
#    accelFactor = "0.015";
#    vertEdgeScroll = false;
#    fingersMap = [ 0 0 0 ];
#    buttonsMap = [ 1 3 2 ];
#    additionalOptions = ''
#      Option "VertScrollDelta" "-150"
#      Option "HorizScrollDelta" "-150"
#      Option "AccelerationProfile" "2"
#      Option "ConstantDeceleration" "4"
#      Option "LockedDrags" "1"
#    '';
#  };

# Option "FingerLow" "50"
# Option "EmulateTwoFingerMinZ" "40"
# Option "EmulateTwoFingerMinW" "8"
# Option "CoastingSpeed" "20"
# Option "CoastingFriction" "20"
# Option "MaxTapTime" "150"

  hardware.trackpoint.speed = 280;
  services.xserver.multitouch.enable = true;
  services.xserver.multitouch.invertScroll = true;

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = true;

  # xset r rate 220 40  # [delay] [rate]
  services.xserver.autoRepeatDelay = 220;
  services.xserver.autoRepeatInterval = 40;

  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:ctrl";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.printing.enable = true;

  #--------
  # network
  #--------

  networking.hostName = "earth";
  networking.networkmanager.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  services.openssh.enable = true;

  programs.mtr.enable = true;

  #---------
  # terminal
  #---------

  environment.sessionVariables = {
    EDITOR = "vim";
    #GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
  };

  programs.bash.enableCompletion = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # emacs prompt
  #programs.bash.promptInit = "PS1=\"# \"";

  #---------
  # packages
  #---------

  nixpkgs.config.allowUnfree = true;

  # search packages > `nix-env -qaP | grep wget`
  environment.systemPackages = let
    sysPackages = with pkgs; [

      # scripting
      graphviz
      python36Packages.xcffib
      rWrapper # https://github.com/NixOS/nixpkgs/tree/master/pkgs/development/r-modules

      # X
      libinput
      xlibs.xmessage
      xorg.xorgserver
      xorg-rgb
      xorg.xf86inputlibinput
      xorg.xorgcffiles
      xorg.xorgsgmldoctools
      xorg_sys_opengl

      # navigation
      albert
      dmenu
      xmonad-with-packages
      xmonad_log_applet_gnome2

      # communication
      scudcloud
      skype

      # security
      browserpass
      pass

      # crypto
      gnupg1
      solc

      # media
      audacity
      blender
      gimp
      imagemagick
      inkscape
      lame.lib
      picard
      rtorrent
      vlc
      youtube-dl

      # term
      automake
      binutils
      cmake
      coreutils
      gcc_debug
      gnum4
      file
      gitAndTools.gitFull
      gitAndTools.tig
      htop
      jq
      man
      libtool
      nfs-utils
      sudo
      tmux
      tree
      unrar
      unzip
      vimHugeX
      xclip

      # emulation
      wine
      urbit

      # web
      chromium
      #(chromium.override { enablePepperFlash = true; })
      chrome-gnome-shell
      drive
      dropbox-cli
      firefox
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
      xfce.thunar-dropbox-plugin

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
      pandoc
      xfontsel
      xlsfonts
      xpdf
      #zathura

      # gnome
      arc-icon-theme
      arc-theme
      font-manager
      gnome3.gdm
      gnome3.gnome-characters
      gnome3.gnome-nettool
      gnome3.gnome-screenshot
      gnome3.gnome_shell
      gnome3.gnome-shell-extensions
      gnome3.networkmanagerapplet
      gtk-engine-murrine
      gtk_engines
      paper-icon-theme
      rhythmbox

      # kde
      #kdeplasma-addons
      #latte-dock
      #plasma5.kdecoration
      #plasma5.khotkeys
      #plasma5.systemsettings
      #plasma-workspace
      #kde-gtk-config
      #kdeFrameworks.kiconthemes

      # nix
      cabal2nix
      nix-prefetch-git
      nix-prefetch-scripts
      nix-repl
      nixops
      nox

      # emacs
      emacs
      emacs-all-the-icons-fonts

      # haskell
      ghc
      haskellPackages.xmonad-contrib
      haskellPackages.xmonad-extras
      haskellPackages.xmonad
      haskellPackages.xmobar
      hasklig
      stack
    ];
    vimPackages   = import /home/hxrts/system/nixos/modules/vim/vim.nix pkgs;
    emacsPackages = import /home/hxrts/system/nixos/modules/emacs/emacs.nix pkgs;
  in
    sysPackages ++ vimPackages ++ emacsPackages;

  nixpkgs.config.chromium = {
    #enablePepperFlash = true;
    enablePepperPDF = true;
  };


  #------
  # users
  #------

  users.extraUsers.hxrts = {
    name  = "hxrts";
    group = "users";
    extraGroups = [
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

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      iosevka
      emacs-all-the-icons-fonts
      emojione
      noto-fonts
      noto-fonts-emoji
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Iosevka Type Light" ];
      sansSerif = [ "Source Sans Pro" ];
      serif     = [ "Source Serif Pro" ];
    };
  };

  #----
  # end
  #----

}
