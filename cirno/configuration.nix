# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  klipper_rules = pkgs.callPackage ./klipper-udev-rules/default.nix { inherit pkgs; }; 
in 
  {
    imports =
      [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #containers for Klipper
      ./containers/a20m.nix
      ./containers/nitori.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define your hostname.
  networking.hostName = "cirno";

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.interfaces.enp3s0.useDHCP = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nouveau"];
  boot.initrd.kernelModules= ["nouveau"];

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "plex" ]; # Enable ‘sudo’ for the user.
  };

   #Wheel doesn't need password
   security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     #vim 
     htop
     wget
     firefox
     chromium
     mpv
     unstable.lightly-qt
     paper-icon-theme
     qbittorrent
     git
     feh
     #custom vim config
     (import ./vim/vim.nix)
   ];
   services.udev.packages = [ klipper_rules ];



services.mainsail.enable = true;
  # Fonts
  fonts.fonts = with pkgs; [
    source-sans-pro
    ibm-plex
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
    powerline-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Fix for alsa/pulse
  # Turns off timer-based scheduling
  hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" {} ''
    sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
    ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
  '';

  # Enable NTFS support 
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.initrd.kernelModules = [ "nouveau" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.plex = {
    enable = true;
    openFirewall = true;
  };

# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [7125 7126 80 5000 8080];
networking.firewall.allowedUDPPorts = [ ];

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "21.11"; # Did you read the comment?

}

