{ pkgs } :

let 
  nixos-container = "/run/current-system/sw/bin/nixos-container";
  sh = pkgs.bash;
  rules-file = "44-klipper-tty-usb.rules";
  usb-add = "'ACTION==\"add\", SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"1d50\", ATTRS{idProduct}==\"614e\", RUN+=\"${sh}/bin/sh -c \\\"${nixos-container} stop a20m && ${nixos-container} start a20m\\\"\"'";
  usb-remove = "'ACTION==\"remove\", SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"1d50\", ATTRS{idProduct}==\"614e\", RUN+=\"${sh}/bin/sh -c \\\"${nixos-container} stop a20m\\\"\"'";
in
pkgs.stdenv.mkDerivation {
  name = "klipper-udev-rules";
  src = ./src;

  dontBuild = true;
  dontConfigure = true;

  installPhase =''
    mkdir -p $out/lib/udev/rules.d
    echo ${usb-add} > ${rules-file}
    echo ${usb-remove} >> ${rules-file}
    cp 44-klipper-tty-usb.rules $out/lib/udev/rules.d
    '';
}
