{
  config,
  lib,
  pkgs,
  ...
}: let
  monoFont = "'CodeNewRoman Nerd Font Mono', 'Droid Sans Mono', 'monospace', monospace";
in {
  programs.vscode.profiles.default.userSettings."editor.fontFamily" = monoFont;
  programs.kitty.font.name = monoFont;
}
