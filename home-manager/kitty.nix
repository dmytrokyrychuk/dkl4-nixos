{ config, lib, pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.kitty.theme = "Ayu Light";

  xsession.windowManager.i3.config.terminal = "kitty";
}
