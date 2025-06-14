{
  config,
  lib,
  pkgs,
  ...
}: {
  services.compton = {
    enable = true;
    settings = {
      inactive-dim = 0.05;
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    windowManager.i3.enable = true;
  };
  services.displayManager = {
    defaultSession = "xfce+i3";
  };

  xdg.autostart.enable = true;
  # Nof sure if needed with XFCE
  # services.xserver.desktopManager.runXdgAutostartIfNone = true;

  services.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };
  security.pam.services.gdm.enableGnomeKeyring = true;
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    polkit
    polkit_gnome
    blueman
    evince
    gimp-with-plugins
    pavucontrol
    xfce.xfce4-panel
    xfce.xfce4-i3-workspaces-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-genmon-plugin
    gnome-pomodoro
  ];

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
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
