{ config, pkgs, ... }:

# Grab adblocking hosts file from somebody who cares!
{
  networking.extraHosts = builtins.readFile (builtins.fetchurl {
    url = https://someonewhocares.org/hosts/hosts;
    sha256 = "1idpn7sx0k4bfrlzg3capdvfg17pb0n5lnwhbsaskpd7bkvbndci";
  });
}
