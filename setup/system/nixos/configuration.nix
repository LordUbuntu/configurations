# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Nix build system configuration
  nix = {
    autoOptimiseStore = true;
    useSandbox = true; # slows down builds but further reduces build impurities
    gc = {
      automatic = true; # collect garbage automatically
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };


  # Nixpkgs configuration
  nixpkgs.config = {
    # allowUnfree = true; # allow proprietary blobs (stallman will cry)
    pulseaudio = true; # this just hurts in general, get pipewire in 'ere
  };


  # Boot configuration
  boot = {
    cleanTmpDir = true;
    # hardwareScan = true; # Usually does a good job providing modules you need, but may crash the system
    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
	version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
	configurationLimit = 25;
	# memtest86.enable = true; # a memory testing program, requires unfree
      };
    };
  };


  # Network configuration
  networking = {
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
    hostName = "mercury";
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
    # enable wireless support via wpa_supplicant
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks = {
        TELUS1380 = {
          pskRaw = "389d4e21e14f3ee86a621e29aa0c6a9335abb337f27fb11372c395da80adf2cb";
        };
      };
    };
    dhcpcd.wait = "background";
  };


  # Set your time zone.
  time.timeZone = "America/Vancouver";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  
  services = {
    printing.enable = true;
  };


  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaybee = {
    isNormalUser = true;
    defaultUserShell = pkgs.zsh;
    useDefaultShell = true;
    extraGroups = [ "wheel" "systemd-journal" ];
    createHome = true;
    # todo: switch to doas if possible
  };


  environment.systemPackages = with pkgs; [
    # -- general
    alacritty
    firefox
    # syncthing
    # searx
    # dwarf-fortress # requires unfree
    # spotify # requires unfree
    spotify-tui
    klavaro
    libreoffice
    # some kind of input method engine for internationalization


    # -- multimedia
    ffmpeg
    youtube-dl
    mpv
    cmus
    picard # musicbrainz music tagging
    zathura
    obs-studio
    obs-wlrobs


    # -- tools
    zsh
    bpytop
    htop
    bat
    bcal
    curl
    fasd
    fd
    fzf
    git
    hyperfine
    nnn
    httpie
    ripgrep-all
    silver-searcher
    tree
    universal-ctags
    wget
    exa
    openssh
    cmatrix
    fortune
    buku
    # endlessh
    # syncthing             # TODO setup configurations for this


    # -- programming
    # editors
    neovim
    emacs-nox
    micro
    # python
    python38Full
    python38Packages.pip
    python38Packages.bpython
    python38Packages.black
    python38Packages.flake8
    # common lisp
    sbcl
    lispPackages.quicklisp
    lispPackages.asdf-package-system
    # haskell
    cabal-install
    hlint
    # c/c++
    gcc
    clang
    ccls
    universal-ctags
    # bash/zsh
    shellcheck


    # -- fonts
    hack-font

    
    # mark(up|down) languages
    pandoc
    # codebraid  # TODO investigate
    # tectonic   # TODO investiagte
    # TODO research latex packages and configs for nixos


    # -- desktop
    # TODO gotta work on desktop environment more
    # remember stumpwm, haskell wm, python wm, c wms, swaywm (focus)
  ];


  programs = {
    mtr.enable = true;
    ssh.startAgent = true;
    # gnupg.agent = { enable = true; enableSSHSupport = true; };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    bash = {
      enableCompletion = true;
    };
    # sway = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     swaybg
    #     swayidle
    #     unstable.swaylock-fancy
    #     waybar
    #     bemenu 
    #     grim
    #     imv
    #     kanshi
    #     mako
    #     xwayland
    #     redshift-wlr
    #     wl-clipboard
    #     # clipman
    #     # oguri
    #   ];
    # };
  };


  security.doas.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    autoUpgrade = {
      enable = true; # change to true for automatic updates
      channel = "https://nixos.org/channels/nixos-21.05";
    };
    stateVersion = "21.05"; # You should change this ONLY after NixOS release notes say you should.
  };

}
