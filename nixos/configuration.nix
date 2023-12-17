# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


# TODO: fix to work on both Nvidia and AMD/Intel hardware

{ config, pkgs, lib, ... }:
let
  unstable = import <unstable> { config = config.nixpkgs.config; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nix-alien.nix
    ];

  # TODO:
  # - setup syncthing
  # - log into accounts
  # - sync dotfiles
  # - check windows
  # RESOURCES:
  # - Kernel Parameters: https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html
  # - Learn Nix:
  #     https://nixos.wiki/wiki/NixOS_as_a_desktop
  #     https://www.reddit.com/r/NixOS/comments/113ondu/rice_nixos/
  #     https://github.com/dmadisetti/.dots/tree/template
  #     https://codeberg.org/SkyFox42/NixOS-Config
  #     https://github.com/search?q=dotfiles%20language%3Anix&type=repositories


  # Nix
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "3 days";
    };
    optimise = {
      automatic = true;
      dates = [ "13 hours" ];
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  programs.nix-ld.enable = true;


  # AMD SETUP
  # TODO: move amd stuff to a seperate module and import instead
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-runtime
        rocm-opencl-icd
        rocm-opencl-runtime
        libva
      ];
    };
  };
  systemd = {
    tmpfiles = {
      # add HIP library support
      rules = [
        "L+  /opt/rocm/hip  -  -  -  - ${pkgs.hip}"
      ];
    };
  };


  # Bootloader.
  boot = {
    kernelModules = [ "amdgpu" ];
    kernelParams = [ "quiet" "splash" ];
    loader = {
      # systemd-boot.enable = true;
      grub = {
        enable = true;
        device = "nodev";
	efiSupport = true;
	useOSProber = true;
	configurationLimit = 13;
      };
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;  # default nixos boot splash
    # 	hangs on bootup for some unknown reason
    # see: https://github.com/adi1090x/plymouth-themes
    # plymouth = {
    #   enable = true;
    #   themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["colorful_sliced"];})];
    #   theme = "colorful_sliced";
    # };
  };


  # Enable networking
  networking.hostName = "mercury"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "America/Vancouver";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin uniemoji ];
  };
  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-v32n";
    keyMap = "us";
  };


  # Virtualization
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [
    "amdgpu"
    "modesetting"
    "fbdev"
  ];
  services.xserver.displayManager.job.preStart = "sleep 5";  # give time for plymouth animation
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  environment.gnome.excludePackages = with pkgs.gnome; [
    cheese
    gnome-clocks
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    pkgs.epiphany
    pkgs.gnome-connections  # Remote Desktop Client
    pkgs.gnome-photos
    pkgs.gnome-tour
    seahorse
    simple-scan  # document scanner
    totem
    yelp
  ];


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;


  # flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
    ];
  };


  # Asus laptop stuff
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = true;
  };


  # Syncthing
  services = {
    syncthing = {
      enable = true;
      user = "jaybee";
      dataDir = "/home/jaybee/Sync";
      configDir = "/home/jaybee/Sync/.config/syncthing";
      overrideFolders = true;
    };
  };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;


  # Enabel FWUPD
  # services.fwupd.enable = true;


  # Enable shell stuff
  programs.zsh.enable = true;


  # Environment
  environment = {
    sessionVariables = lib.mkDefault {
      LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
    };
  };


  # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      (nerdfonts.override { fonts = [ "FiraCode" ]; })  # TODO: add more
      open-dyslexic
    ];
    fontconfig = {
      defaultFonts = {
        # TODO: add more nerdfonts for other font styles
        serif = [ "Noto Sans" ];
        sansSerif = [ "Noto Serif" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
      hinting.style = "hintfull";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaybee = {
    isNormalUser = true;
    description = "Jacobus Burger";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "syncthing" "wheel" ];
    # packages = with pkgs; [ ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # nix stuff
    nix-index

    # system utilities
    blender-hip
    clinfo
    coreutils-full
    curl
    file
    git
    htop
    parted
    pciutils
    rocminfo
    unzip
    usbutils
    vulkan-tools
    wget

    # security
    chkrootkit
    lynis

    # virtualisation
    distrobox
    podman
    docker
    docker-compose
    toolbox

    # developer tools
    micro
    neovim
    #   Python 3.10
    python310Full
    python310Packages.pip
    python310Packages.pip-tools # Resistance is fulite
    python310Packages.pipx      # I must be assimilated !_!
    # 	C/C++
    gcc
    clang
    gnumake
    unstable.wezterm
    # Rust
    rustup

    # cli tools
    bat
    bat-extras.batman
    bat-extras.batgrep
    bat-extras.batdiff
    btop
    cbonsai
    cmus
    delta
    duf
    exa
    fasd
    fd
    fzf
    httpie
    hyperfine
    neofetch
    nnn
    nvtop
    ripgrep
    ripgrep-all
    starship
    tree-sitter
    zellij
    zlib.dev
    zsh

    # documents
    pandoc
    texlive.combined.scheme-full
    zathura

    # GUI
    amberol
    anki
    audacity
    blender
    cura
    discord
    firefox
    google-chrome
    inkscape
    klavaro
    krita
    libresprite  # aseprite atl
    lmms
    mpv
    obs-studio
    unstable.obsidian
    spotify
    vscode-fhs
    
    # Gnome
    celluloid  # mpv frontend
    dynamic-wallpaper
    eyedropper
    gnome.gnome-color-manager
    gnome.gnome-mahjongg
    gnome.gnome-software  # make sure flatpak is setup with flathub
    gnome.gnome-tweaks
    gnome.pomodoro
    gnomeExtensions.caffeine
    gnomeExtensions.custom-accent-colors
    gnomeExtensions.just-perfection
    metadata-cleaner
    pika-backup
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
