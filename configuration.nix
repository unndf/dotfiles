# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hosts.nix
    ];


  # Use GRUB instead of Systemdboot
  # Grub has osProber for dualboot
  boot.loader.grub.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.loader.grub.splashImage = ./comfy.png;

  networking.hostName = "gensokyo";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Edmonton";

  nix.extraOptions = ''
    auto-optimise-store = true
    '';

  nixpkgs.config.packageOverrides = pkgs: rec {
        # use mpv with CD support
        mympv = pkgs.mpv.override { cddaSupport = true; };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget
    discord
    chromium
    ntfs3g
    samba
    gimp
    gwenview
    ksysguard
    libmtp
    screenfetch
    qbittorrent
    okular
    feh
    attr
    htop
    nix-prefetch-scripts
    youtube-dl
    kdeconnect
    kdeApplications.kdenetwork-filesharing
    kdeApplications.ark
    kdeApplications.kio-extras
    kdeApplications.baloo-widgets
    qtcreator
    picard
    ctags
    abcde
    adapta-kde-theme
    git
    libreoffice
    obs-studio
    p7zip
    powerline-fonts
    qbittorrent
    spectacle
    spek
    unrar
    unzip

     # Overriden packages
     mympv
     (import ./vim/vim.nix) 
   ];

  # Open ports for KDE Connect & Plex
  networking.firewall.allowedTCPPorts = [
    1714 1715 1716 1717 1718 1719
    1720 1721 1722 1723 1724 1725 1726 1727 1728 1729
    1730 1731 1732 1733 1734 1735 1736 1737 1738 1739
    1740 1741 1742 1743 1744 1745 1746 1747 1748 1749
    1750 1751 1752 1753 1754 1755 1756 1757 1758 1759
    1760 1761 1762 1763 1764 8200
  ];

  networking.firewall.allowedUDPPorts = [
    1714 1715 1716 1717 1718 1719
    1720 1721 1722 1723 1724 1725 1726 1727 1728 1729
    1730 1731 1732 1733 1734 1735 1736 1737 1738 1739
    1740 1741 1742 1743 1744 1745 1746 1747 1748 1749
    1750 1751 1752 1753 1754 1755 1756 1757 1758 1759
    1760 1761 1762 1763 1764 1900
  ];

  #fonts
  fonts.fonts = with pkgs; [
    source-sans-pro
    ibm-plex
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
    powerline-fonts
  ];

  programs.bash.enableCompletion = true;

  services.openssh.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  #Enable wacom tablet
  services.xserver.wacom.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl.enable = true;

  hardware.opengl.driSupport32Bit = true;

  # Enable Virtualbox
  virtualisation.virtualbox.host.enable = true;

  # Enable plex
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # users
  users.users.dev =
    { isNormalUser = true;
    home = "/home/dev";
    extraGroups = ["wheel" "audio" "media" "vboxusers" "video"];
  };

   # wheel's don't need password
   security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
  system.autoUpgrade.enable = true;

  #ssh X11 forwarding
  services.openssh.forwardX11 = true;
}
