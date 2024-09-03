{ config, pkgs, ... }:

# COntainer for a20m 3d printer with BTT Octopus Board
{
  containers.a20m = {
    autoStart = true;
    bindMounts = {
      "/dev/hostdev" = {
        hostPath = "/dev";
        isReadOnly = false;
      };
      "/etc/nixos/klipper" = {
        hostPath = "/etc/nixos/klipper";
        isReadOnly = true;
      };
    };
    allowedDevices = [
      {
        modifier = "rwm";
        node = "/dev/serial/by-id/usb-Klipper_stm32f446xx_250033000851313133353932-if00";
      }{
        modifier = "rwm";
        node = "/dev/ttyACM0";
      }{
        modifier = "rwm";
        node = "/dev/ttyACM1";
      }
    ];
    config = { config, pkgs, ... }: {
      networking.firewall.allowedTCPPorts = [7125 80 5000 8080 7126];
      services.klipper = {  
        enable = true;
        octoprintIntegration = true;
        logFile = "/var/lib/klipper/klipper.log";
        configFile = "/etc/nixos/klipper/octopus-a20m.cfg";
        firmwares = {
      bttoctopusmcu = {
        enable = true;
        # Run klipper-genconf to generate this
        configFile = ../klipper/bttoctopus.cfg;
        # Serial port connected to the microcontroller
        serial = "/dev/serial/by-id/usb-STMicroelectronics_MARLIN_BIGTREE_OCTOPUS_V1_CDC_in_FS_Mode_326C35583131-if00";
      };
    };  
  };
  services.octoprint.enable = true;
  services.moonraker.enable = true;
  services.moonraker.user = "root";
  services.moonraker.address = "0.0.0.0";
  services.moonraker.port = 7126;
  services.moonraker.settings = {
    file_manager = {
      enable_object_processing = true;
    };
    authorization = {
      force_logins = true;
      cors_domains = [
        "*.local"
        "*.lan"
        "https://app.fluidd.xyz"
        "https://app.fluidd.xyz"
        "http://my.mainsail.xyz"
        "https://my.mainsail.xyz"
      ];
      trusted_clients = [
        "10.0.0.0/24"
        "10.0.0.0/8"
        "10.0.0.10"
        "127.0.0.0/8"
        "169.254.0.0/16"
        "172.16.0.0/12"
        "192.168.0.0/16"
        "FE80::/10"
        "::1/128"
      ];
    };
  };
};
};
}
