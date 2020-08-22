# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nixos-unstable =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  # TODO create a generic config.nix for use across devs
  # import said file to detach it from configuration.nix
  # 
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Nix
  nix = {
    autoOptimiseStore = true;
    # useSandbox = true; # slows down builds but further reduces build impurities
    gc = {
      automatic = true; # collect garbage automatically
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
    packageOverrides = pkgs: {
      unstable = import nixos-unstable {
        config = config.nixpkgs.config;
      };
    };
  };


  # Environment
    # Packages
  # environment.systemPackages =
  #   let devTools = with pkgs; [ curl wget neovim git ];
  #       devLangs = with pkgs; [ gcc python2 python3 ];
  #       desktop = with pkgs; [ sway kitty firefox ];
  #       misc = with pkgs; [ cmatrix dwarf-fortress syncthing ];
  #   in builtins.concatLists [ devTools devLangs desktop misc ];
  # environment.variables = {
  #   EDITOR="nvim";
  #   BROWSER="firefox";
  #   # ...
  # };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    wget
    neovim
    fzf
    git
    tree
    python3
    python38Packages.pip
    gcc
    alacritty
    firefox-wayland
  ];
  environment.variables = {
    EDITOR="nvim";
    BROWSER="firefox";
  };


  # User-Groups
  users.defaultUserShell = pkgs.zsh;
  users.users.jaybee = {
    isNormalUser = true;
    useDefaultShell = true;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" "sway" "systemd-journal" ]; # wheel == ring == sudo
    createHome = true;
  };


  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  #   Systemd-boot boot loader (UEFI)
  boot = {
    cleanTmpDir = true;
    hardwareScan = true; # Usually does a good job providing modules you need, but may crash the system
    loader = {
      systemd-boot = {
        enable = true; # Use the systemd-boot EFI boot loader.
	configurationLimit = 3;
	memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    plymouth = {
      enable = true;
      # TODO change bootsplash theme to something from that repo i found
      # TODO add more plymouth themes to nixos based off the git repo i found.
    };
  };


  # Networking
  networking = {
    hostName = "venus"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enables wireless support via network manager
    tcpcrypt.enable = true; # best effort tcp encryption
    useDHCP = false; # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    interfaces = {
      enp3s0.useDHCP = true; # Per-interface useDHCP will be mandatory in the future, so this generated config replicates the default behaviour.
    };
    firewall = { # TODO better configure firewall
      enable = false;
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };
    # TODO enable and configure wireguard
  };


  # Services
  services = {
    sshd.enable = true;
    printing.enable = true; # Enable CUPS to print documents
    haveged.enable = true; # refill entropy
    localtime.enable = true; # set time by location
    openssh = {
      enable = true; # TODO enable openssh daemon
      allowSFTP = true;
      # ports = [ 63621 ];
    };
    redshift = {
      enable = true;
      brightness.day = "1";
      brightness.night = "0.65";
      temperature.day = 8000;
      temperature.night = 1900;
    };
  #   syncthing = {
  #     enable = true;
  #     dataDir = "/home/jaybee/syncthing";
  #   };
  # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
      displayManager.lightdm.enable = true;
      # windowManager.xmonad.enable = true;
    };
  };


  # Programs
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
    sway = {
      enable = true;
      extraPackages = with pkgs; [
	swaybg
	swayidle
	unstable.swaylock-fancy
	waybar
	bemenu 
        grim
	imv
	kanshi
	mako
	xwayland
	redshift-wlr
	wl-clipboard
	# clipman
	# oguri
      ];
    };
  };


  # Hardware
  hardware = {
    bluetooth.enable = false; # TODO change to 'true'
    pulseaudio.enable = true; # Enable pulseaudio to play sound
    opengl = { # Enable opengl rendering support for wayland
      enable = true;
      driSupport = true;
    };
  };


  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      fira-code
      hack-font
      nerdfonts
      unifont
    ];
    fontconfig.defaultFonts.monospace = [ "Hack" ];
  };


  # Locale
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ libpinyin unikey ]; # cloudpinyin 
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  # System
  system = {
    autoUpgrade = {
      enable = true; # change to true for automatic updates
      channel = "https://nixos.org/channels/nixos-20.03";
    };
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "20.03"; # Did you read the comment?  # You should change this ONLY after NixOS release notes say you should.
  };

  
  # Miscellaneous
  sound.enable = true; # Enable sound.
  time.timeZone = "America/Vancouver"; # Set your time zone.
  location.provider = "geoclue2";
}
