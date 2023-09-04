# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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


  # Boot
  boot = {
    kernelModules = [ "amdgpu" ];
    kernelParams = [ "quiet" "splash" ];  # remember: ESC to see status
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

    # see: https://github.com/adi1090x/plymouth-themes
    plymouth = {
      enable = true;
      theme = "colorful_sliced";
      themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["colorful_sliced"];})];
    };
  };


  # Virtualization
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
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


  networking.hostName = "mercury"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin uniemoji ];
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.videoDrivers = [ "amdgpu" ];


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.job.preStart = "sleep 5"; # wait for plymouth before starting gdm
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  # services.gnome.sushi.enable = true;
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
    pkgs.gnome-console
    pkgs.gnome-photos
    pkgs.gnome-tour
    seahorse
    simple-scan  # document scanner
    totem
    yelp
  ];
  # MANUAL STUFF TO DO:
  # - setup fractional scaling on gnome
  # `gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"`
  # - then setup hidden icons
  # `files="btop.desktop cups.desktop htop.desktop krita_brush.desktop krita_csv.desktop krita_exr.desktop krita_gif.desktop krita_heif.desktop krita_heightmap.desktop krita_jp2.desktop krita_jpeg.desktop krita_jxl.desktop krita_kra.desktop krita_krz.desktop krita_ora.desktop krita_pdf.desktop krita_png.desktop krita_psd.desktop krita_qimageio.desktop krita_raw.desktop krita_spriter.desktop krita_svg.desktop krita_tga.desktop krita_tiff.desktop krita_webp.desktop krita_xcf.desktop micro.desktop nnn.desktop nvim.desktop org.pwmt.zathura-cb.desktop org.pwmt.zathura-djvu.desktop org.pwmt.zathura-pdf-mupdf.desktop org.pwmt.zathura-ps.desktop org.pwmt.zathura.desktop scrcpy-console.desktop startcenter.desktop umpv.desktop xsltfilter.desktop xterm.desktop zathura.desktop"`
  # `for f in $files; do touch /home/jaybee/.local/share/applications/$f; echo "[Desktop Entry]\nNoDisplay=true\nHidden=true" > /home/jaybee/.local/share/applications/$f; done`


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
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaybee = {
    isNormalUser = true;
    description = "Jacobus Burger";
    extraGroups = [ "networkmanager" "wheel" "syncthing" ];
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
      amberol
      authenticator
      dynamic-wallpaper
      eyedropper
      gnome.gnome-color-manager
      gnome.gnome-mahjongg
      gnome.gnome-tweaks
      # gnome.gnome-terminal  # for when wezterm isn't working
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
      wezterm  # jank on gnome
      zellij
      zsh

      # pdf stuff
      zathura
      pandoc
      texlive.combined.scheme-full
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
    unzip

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
    gnomeExtensions.custom-accent-colors
    gnomeExtensions.caffeine
    gnomeExtensions.just-perfection

    blender-hip
  ];


  # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      (nerdfonts.override { fonts = [ "FiraCode" ]; })  # TODO: add more
      liberation_ttf
    ];
    fontconfig = {
      defaultFonts = {
        # TODO: add more nerdfonts for other font styles
        serif = [ "Noto Sans" ];
        sansSerif = [ "Noto Serif" ];
        monospace = [ "Noto Sans Mono" "FiraCode Nerd Font Mono" ];
      };
      hinting.style = "hintfull";
    };
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
