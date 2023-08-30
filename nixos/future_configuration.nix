# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hidden-apps.nix
    ];


  # Hardware
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-runtime
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };


  boot = {
    # Bootloader
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 13;
      };
    };

    # use adi1090x plymouth themes
    plymouth = { };
  };


  # Systemd
  systemd = {
    tmpfiles = {
      # add HIP library support
      rules = [
        "L+  /opt/rocm/hip  -  -  -  - ${pkgs.hip}"
      ];
    };
  };


  # Networking
  networking = {
    hostName = "mercury";
    networkmanager = {  # enable networking
      enable = true;
    };
  };


  # Time
  time = {
    timeZone = "America/Vancouver";  # TODO: setup automatic timezone stuff to avoid hardcoding it
    hardwareClockInLocalTime = true;
  };


  # Localization
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin uniemoji ];
    };
  };


  # Services
  services = {
    # X11
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager = {
        # Gnome DE
        gdm.enable = true;
      };
      desktopManager = {
        # Gnome DE
        gnome = {
          enable = true;
          # TODO: make gnome setup more declarative in future
          extraGSettingsOverrides = ''
            [org/gnome/mutter]
            experimental-features=['scale-monitor-framebuffer']
          '';
        };
        xterm.enable = false;
      };
      excludePackages = with pkgs; [ xterm ];
    };
    # Gnome DE
    gnome = {
      sushi.enable = true;
    };
  };


  # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      # noto-fonts-cjk
      # fira-code
      nerdfonts
      liberation_ttf
    ];
  };


  # Environment
  environment = {
    # Gnome DE
    gnome = {
      excludePackages = with pkgs.gnome; [
        cheese
        gnome-clocks  # replaced by pomodoro
        pkgs.gnome-connections  # Remote Desktop Client
        pkgs.gnome-console
        gnome-contacts
        seahorse
        simple-scan  # document scanner
        yelp
        gnome-logs
        gnome-maps
        pkgs.gnome-photos
        pkgs.gnome-tour
        totem
        pkgs.epiphany
      ];
    };
  };


  # Hide Apps I don't want to see in gnome activies view
  # Thanks to Max Headroom (https://git.privatevoid.net/max/config/-/blob/master/modules/desktop/default.nix)
  desktop.hiddenApps = [
    "cups.desktop"
    "nnn.desktop"
    "umpv.desktop"
    "btop.desktop"
    "nvim.desktop"
    "zathura.desktop"  # this one's a bit iffy
    "org.pwmt.zathura-cb.desktop"
    "org.pwmt.zathura-djvu.desktop"
    "org.pwmt.zathura-pdf-mupdf.desktop"
    "org.pwmt.zathura-ps.desktop"
    "org.pwmt.zathura.desktop"
    "micro.desktop"
    "htop.desktop"
    "startcenter.desktop" # LibreOffice Start Center
    "xsltfilter.desktop" # LibreOffice XSLT based filters
    "xterm.desktop"
    "scrcpy-console.desktop"
    # all the Krita mimetype stuff
    "krita_brush.desktop"
    "krita_csv.desktop"
    "krita_exr.desktop"
    "krita_gif.desktop"
    "krita_heif.desktop"
    "krita_heightmap.desktop"
    "krita_jp2.desktop"
    "krita_jpeg.desktop"
    "krita_jxl.desktop"
    "krita_kra.desktop"
    "krita_krz.desktop"
    "krita_ora.desktop"
    "krita_pdf.desktop"
    "krita_png.desktop"
    "krita_psd.desktop"
    "krita_qimageio.desktop"
    "krita_raw.desktop"
    "krita_spriter.desktop"
    "krita_svg.desktop"
    "krita_tga.desktop"
    "krita_tiff.desktop"
    "krita_webp.desktop"
    "krita_xcf.desktop"
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


  # Virtualisation
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };


  # asusctl
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaybee = {
    isNormalUser = true;
    description = "Jacobus Burger";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # GUI
      anki
      blender
      cura
      discord
      firefox
      firefox
      google-chrome
      inkscape
      klavaro
      krita
      lmms
      mpv
      obs-studio
      obsidian
      spotify
      vscode-fhs
      # sioyek
      # Gnome stuff
      # for a full list of gnome apps, see https://apps.gnome.org
      authenticator
      dynamic-wallpaper
      eyedropper
      gnome.gnome-color-manager
      gnome.gnome-mahjongg
      gnome.gnome-tweaks
      gnome.pomodoro
      metadata-cleaner
      pika-backup
      raider
      # Gnome Extensions
      gnomeExtensions.blur-my-shell
      gnomeExtensions.burn-my-shell
      gnomeExtensions.custom-accent-colors
      gnomeExtensions.espresso
      gnomeExtensions.forge  # tiling goodness
      gnomeExtensions.just-perfection
      gnomeExtensions.next-up
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.user-themes

      # CLI
      btop
      cbonsai
      cmus
      httpie
      hyperfine
      neofetch
      starship
      wezterm
      zathura
      zellij
      # zsh and zsh deps
      zsh
      bat
      delta
      duf
      exa
      fasd
      fd
      fzf
      nnn
      ripgrep
      ripgrep-all

      # Dev tools
      neovim
      micro
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system utilities
    coreutils-full
    busybox
    rocminfo
    vulkan-tools
    clinfo
    pciutils
    usbutils
    wget
    curl
    git
    htop
    parted
    file

    # security
    chkrootkit
    lynis

    # virtualisation
    podman
    distrobox
    toolbox

    # developer utilities
    python310Full
    python310Packages.pip
    python310Packages.pipx       # I must be assimilated !_!
    python310Packages.pip-tools  # Resistance is futile
    neovim
    micro
  ];


  # openssh
  services.openssh.enable = true;
  programs.ssh.startAgent = true;




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
