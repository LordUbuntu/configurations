# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hidden-apps.nix
    ];

  # TODO:
  # - setup plymouth config
  # - check windows
  # - setup secure boot
  # - setup power management
  # - setup polkit


  # AMD SETUP
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
        # amdvlk
      ];
      extraPackages32 = with pkgs; [
        # driversi686Linux.amdvlk
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


  # Boot
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
    plymouth = {
      enable = true;
      # theme = "";
      # themePackages = with pkgs; [ adi1090x-plymouth-themes ];
    };
  };


  # Virtualization
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      extraPackages = with pkgs; [
        # gvisor  # container sandboxing
      ];
    };
  };


  # Asus laptop stuff
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd.enable = true;
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # GNOME DE
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  services.gnome.sushi.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org/gnome/mutter]
    experimental-features=['scale-monitor-framebuffer']
  '';  # fractional scaling ^^^
  environment.gnome.excludePackages = with pkgs.gnome; [
    cheese
    gnome-clocks
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
  # Hide Apps I don't want to see in gnome activies view
  # Thanks to Max Headroom (https://git.privatevoid.net/max/config/-/blob/master/modules/desktop/default.nix)
  desktop.hiddenApps = [
    "btop.desktop"
    "cups.desktop"
    "htop.desktop"
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
    "micro.desktop"
    "nnn.desktop"
    "nvim.desktop"
    "org.pwmt.zathura-cb.desktop"
    "org.pwmt.zathura-djvu.desktop"
    "org.pwmt.zathura-pdf-mupdf.desktop"
    "org.pwmt.zathura-ps.desktop"
    "org.pwmt.zathura.desktop"
    "scrcpy-console.desktop"
    "startcenter.desktop" # LibreOffice Start Center
    "umpv.desktop"
    "xsltfilter.desktop" # LibreOffice XSLT based filters
    "xterm.desktop"
    "zathura.desktop"  # this one's a bit iffy
    # all the Krita mimetype stuff
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


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


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
      # Gnome Apps, for a full list of gnome apps, see https://apps.gnome.org
      authenticator
      dynamic-wallpaper
      eyedropper
      gnome.gnome-color-manager
      gnome.gnome-mahjongg
      gnome.gnome-tweaks
      gnome.pomodoro
      metadata-cleaner
      pika-backup

      # CLI
      bat
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
      ripgrep
      ripgrep-all
      starship
      wezterm
      zathura
      zellij
      zsh
    ];
  };


  # System packages
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

    # Gnome Extensions
    # recommended: manual install
    # burn-my-windows
    # blur-my-shell
    # custom-accent-colors
    # expresso
    # forge
    # just-perfection
    # next-up
  ];


  # Networking
  networking = {
    networkmanager.enable = true;
    hostName = "mercury";  # defire your hostname
  };


  # Time
  time.timeZone = "America/Vancouver";


  # Internationalization
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin uniemoji ];
    };
  };


  # SSH
  services.openssh.enable = true;
  programs.ssh.startAgent = true;


  # Security
  services.fwupd.enable = true;  # dbus firmwrae updtaer, for gnome device security thingy


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
