{ config, lib, pkgs, ... }:
{
  services.compton = {
    enable = true;
    settings = {
      inactive-dim = 0.05;
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
  };

  xdg.autostart.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  environment.systemPackages = with pkgs; [
    polkit
    polkit_gnome
  ];
  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
