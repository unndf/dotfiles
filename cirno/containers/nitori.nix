{ config, pkgs, ... }:

{
  containers.nitori = {
    autoStart = true;
    bindMounts = {
      "/dev/ttyUSB0" = {
      hostPath = "/dev/ttyUSB0";
      isReadOnly = false;
      };
      "/dev/serial" = {
      hostPath = "/dev/serial";
      isReadOnly = false;
      };
      "/etc/nixos/klipper" = {
      hostPath = "/etc/nixos/klipper";
      isReadOnly = true;
      };
      };
      allowedDevices = [
      {
      modifier = "rw";
      node = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
    }
  ];
  config = { config, pkgs, ... }: {
    networking.firewall.allowedTCPPorts = [7125 7126 80 5000 8080];
    services.klipper = {  
      enable = true;
      octoprintIntegration = true;
      logFile = "/var/lib/klipper/klipper.log";
      configFile = "/etc/nixos/klipper/generic-gt2560-v4.cfg";
      firmwares = {
        a20mmcu = {
          enable = true;
        # Run klipper-genconf to generate this
        configFile = ../klipper/avr.cfg;
        # Serial port connected to the microcontroller
        serial = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
      };
    };  
  };
  services.octoprint.enable = true;
  services.moonraker.enable = true;
  services.moonraker.user = "root";
  services.moonraker.address = "0.0.0.0";
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
