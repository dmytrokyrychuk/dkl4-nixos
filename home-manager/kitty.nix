{...}: {
  programs.kitty.enable = true;
  programs.kitty.theme = "Ayu Light";

  xsession.windowManager.i3.config.terminal = "kitty";

  # Fix issues with missing terminfo when connecting to remote machines via SSH
  programs.kitty.environment = {
    TERM = "xterm-256color";
  };
  programs.ssh.extraConfig = ''
    SetEnv TERM=xterm-256color
  '';
}
