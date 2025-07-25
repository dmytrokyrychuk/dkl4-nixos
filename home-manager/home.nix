{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./i3.nix
    ./fonts.nix
    ./kitty.nix
    ./rofi.nix
    ./firefox.nix
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "dmytro";
    homeDirectory = "/home/dmytro";
    packages = with pkgs; [
      speedcrunch
      calibre
      dbeaver-bin
      kazam
      remmina
      winbox
      postman
      element-desktop
      fstl
      freecad
      rpi-imager
      realvnc-vnc-viewer
      signal-desktop
      avidemux
      openshot-qt
      clockify
      citrix_workspace
      azuredatastudio
    ];
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.volantes-cursors;
      name = "volantes-cursors";
    };
  };
  # Add stuff for your user as you see fit:
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = ''
      :set number
      :set relativenumber
    '';
  };

  programs.home-manager.enable = true;

  programs.git.enable = true;
  programs.git.userName = "Dmytro Kyrychuk";
  programs.git.userEmail = "dmytro@kyrych.uk";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    rebase.autostash = true;
  };
  programs.git.aliases = {
    fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup";
  };
  programs.git.includes = [
    {path = "${config.xdg.configHome}/git/config_private";}
  ];

  programs.qutebrowser.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          vscodevim.vim
          jnoortheen.nix-ide
          oderwat.indent-rainbow
          arrterian.nix-env-selector
          ms-python.python
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-containers
          github.copilot
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-icons";
            publisher = "vscode-icons-team";
            version = "12.2.0";
            sha256 = "sha256-PxM+20mkj7DpcdFuExUFN5wldfs7Qmas3CnZpEFeRYs=";
          }
          {
            name = "ayu";
            publisher = "teabyii";
            version = "1.0.5";
            sha256 = "sha256-+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
          }
        ];
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings.nil.formatting.command" = ["nixpkgs-fmt"];

        "workbench.colorTheme" = "Ayu Light";
        "workbench.iconTheme" = "vscode-icons";

        "remote.SSH.useLocalServer" = false;
        "remote.SSH.remotePlatform" = {
          "dkvm03.home.kyrych.uk" = "linux";
          "experiments.home.kyrych.uk" = "linux";
        };

        "editor.lineNumbers" = "relative";
        "editor.renderWhitespace" = "trailing";
        "editor.rulers" = [80 120];
        "editor.formatOnSave" = true;

        "dotfiles.repository" = "dmytrokyrychuk/devcontainer-dotfiles";
        "terminal.integrated.defaultProfile.linux" = "fish";

        "vim.handleKeys" = {
          "<C-p>" = false;
        };
        "vim.easymotion" = true;

        "git.openDiffOnClick" = false;
        "scm.defaultViewMode" = "tree";

        "zenMode.fullScreen" = false;

        "vsicons.dontShowNewVersionMessage" = true;
      };
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.sessionVariables.DIRENV_WARN_TIMEOUT = "10s";
  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting  # Disable greeting
    '';
  };
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;
    forwardAgent = true;
    addKeysToAgent = "yes";
    includes = ["${config.home.homeDirectory}/.ssh/config_private"];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
