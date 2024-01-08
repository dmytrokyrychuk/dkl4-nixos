{ config, lib, pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      startup = [
      ];
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
  };
}
