{ config, lib, pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      startup = [
        {
          command = "xfce4-panel --disable-wm-check";
        }
      ];
      bars = lib.mkForce [ ]; # disable i3status in favor of xfce4-panel
      keybindings =
        let
          mod = "Mod1";
          left = "h";
          down = "j";
          up = "k";
          right = "l";
        in
        lib.mkOptionDefault {
          # Focus
          "${mod}+${left}" = "focus left";
          "${mod}+${right}" = "focus right";
          "${mod}+${up}" = "focus up";
          "${mod}+${down}" = "focus down";

          # Move
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${right}" = "move right";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${down}" = "move down";
        };
    };
    extraConfig = ''
      set $small eDP-1
      set $big DP-1
      workspace 1 output $small
      workspace 2 output $big
      workspace 3 output $big
      workspace 4 output $big
      workspace 5 output $big
      workspace 6 output $small
      workspace 7 output $small
      workspace 8 output $big
      workspace 9 output $small
    '';
  };
}
