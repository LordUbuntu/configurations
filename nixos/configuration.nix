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
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd ];
  };

  # Bootloader.
  boot = {
    loader = {
      timeout = 5;
      efi = {
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        configurationLimit = 13;
        useOSProber = true;
      };
    };

    plymouth = { };  # use adi1090x plymoutht themes

    # vfio passthrough
    kernelParams = [ "amd_iommu=on" ];
    # you shouldn't and can't do blacklist the driver if it's the same brand for both
    # blacklistedKernelModules = [ "amdgpu" ];
    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    extraModprobeConfig = "options vfio-pci ids=1002:73df,1002:ab28";
    # Group11: 1002:73df (NAVI GPU)
    # Group12: 1002:ab28 (NAVI Audio)
    postBootCommands = ''
        DEVS="0000:03:00.0 0000:03:00.1"

        for DEV in $DEVS; do
            echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done
        modprobe -i vfio-pci
    '';
  };



  networking.hostName = "mercury"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";


  # attempt to use chinese input methods
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin uniemoji ];
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    # noto-fonts-emoji
    fira
    # fira-code
    # fira-code-symbols
    # nerdfonts
    # liberation_ttf
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Noto Sans Mono"
      "Noto Sans CJK"
    ];
    sansSerif = [
      "Noto Sans"
      "Noto Sans CJK"
    ];
    serif = [
      "Noto Sans Serif"
      "Noto Sans CJK"
    ];
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.sushi.enable = true;
  # NOTE: may remove more here in the future
  environment.gnome.excludePackages = with pkgs.gnome; [
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

  # hide apps I don't want to see in gnome activites view
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
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # asusctl for laptop
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
      settings = ''
{
  "mode": "Vfio",
  "vfio_enable": true,
  "vfio_save": false,
  "always_reboot": false,
  "no_logind": false,
  "logout_timeout_s": 180,
  "hotplug_type": "None"
}
      '';
    };
  };
  environment.etc."supergfxd.conf".text = with lib; lib.mkForce ''
    {
      "mode": "Vfio",
      "vfio_enable": true,
      "vfio_save": false,
      "always_reboot": false,
      "no_logind": false,
      "logout_timeout_s": 180,
      "hotplug_type": "None"
    }
  '';


  # podman for distrobox
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };


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
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.users.jaybee = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jacobus Burger";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # This is supposed to be for system-wide packages
  environment.systemPackages = with pkgs; [
    # SYSTEM TOOLS
    vulkan-tools
    clinfo
    pciutils
    usbutils
    wget
    curl
    vim
    git

    # USER
      # gui applications
      #   Daily Applications
      discord
      spotify
      obsidian
      firefox
      #   Developer Extras
      google-chrome
      vscode-fhs
      cura
      #   Learning
      anki
      klavaro
      #   Media
      blender
      inkscape
      krita
      obs-studio
      lmms
      mpv
      # sioyek
      # Gnome stuff
      # for a full list of gnome apps, see https://apps.gnome.org
      gnome.gnome-tweaks
      gnome.pomodoro
      gnome.gnome-mahjongg



      # CLI
      neovim
      wezterm
      starship
      zellij

      zathura
      cmus

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

      # developer tools
      python310Full
      python310Packages.pip
      python310Packages.pipx       # I must be assimilated !_!
      python310Packages.pip-tools  # Resistance is futile

      # nicities
      hyperfine
      httpie
      btop
      # pfetch
      neofetch
      cbonsai
      # TODO: figure out how to make python work on Nix
      # - unimatrix  (must install manually)
      # - pyenv      (must install manually)

      # virtualisation
      podman
      distrobox
      virt-manager
      qemu
      qemu-utils
  ];

  time.hardwareClockInLocalTime = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
