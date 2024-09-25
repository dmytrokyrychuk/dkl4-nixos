{pkgs, ...}: {
  users.users.dmytro = {
    extraGroups = ["dialout"];
    packages = with pkgs; [
      mission-planner
      betaflight-configurator
      dfu-util
    ];
  };

  services.udev.extraRules = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/platformio/platformio-core/master/platformio/assets/system/99-platformio-udev.rules";
    hash = "sha256-16O7/yzB85W34NKdHoS6FnJUh5c4fUDcV4jEnQaME8Y=";
  });

  nixpkgs = {
    overlays = [
      (final: prev: {
        # Downgrade nwjs. See https://github.com/NixOS/nixpkgs/issues/305779
        nwjs = prev.nwjs.overrideAttrs {
          version = "0.72.0";
          src = prev.fetchurl {
            url = "https://dl.nwjs.io/v0.72.0/nwjs-v0.72.0-linux-x64.tar.gz";
            hash = "sha256-kWl4867hSA2fgZ80Brs3TFDDXiHSt8Qd9UtSInqQzr8=";
          };
        };
        mission-planner = prev.mission-planner.overrideAttrs rec {
          # Upgrade from 1.3.80, which does not display accel calibration guide,
          # and missing dropdowns in the Full Parameter List.
          version = "1.3.82";
          src = prev.fetchurl {
            url = "https://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-${version}.zip";
            sha256 = "sha256-554fFDxHMo4jV3yrPdGgDYQ6XeW+TWdVIIkGQIBdrCQ=";
          };
        };
      })
    ];
  };
}
