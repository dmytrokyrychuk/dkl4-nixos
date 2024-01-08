{ config, lib, pkgs, ... }:
{
  programs.rofi.enable = true;
  programs.rofi.theme = "Arc-Dark";

  xsession.windowManager.i3.config.menu = "rofi -show combi -matching fuzzy";
}
