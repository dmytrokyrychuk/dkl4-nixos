# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: let
  dmytrokyrychukKeys = let
    content = pkgs.fetchurl {
      url = "https://github.com/dmytrokyrychuk.keys";
      sha256 = "sha256-D45/lJ76om8VioV7uyCl19JbbArkqXCztyDLNlfW52g=";
    };
  in
    pkgs.lib.splitString "\n" (builtins.readFile content);
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hp-probook-430-g6.nix
    ./disko-config.nix
    ./xfce.nix
    ./docker.nix
    ./btrbk.nix
    ./print-scan.nix
    ./flatpak.nix
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;

  console.earlySetup = true;

  networking.hostName = "dkl4";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ua";
  services.xserver.xkb.options = "grp:shifts_toggle";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.root.openssh.authorizedKeys.keys = dmytrokyrychukKeys;
  users.users.dmytro.openssh.authorizedKeys.keys = dmytrokyrychukKeys;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmytro = {
    isNormalUser = true;
    initialPassword = "123456";
    extraGroups = ["wheel" "networkmanager"];
    packages = with pkgs; [
      #    firefox
      #    tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    kakoune
    git
    home-manager
    slack
    google-chrome
    telegram-desktop
    nil
    nixpkgs-fmt
    htop
    tree
    gparted
    spotify
    obsidian
    virt-viewer
    shutter
    gnumeric
    meld
    libreoffice-qt
    gnome.file-roller
    gnome.simple-scan
    #  wget
  ];

  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = ["CodeNewRoman" "DroidSansMono"];
    })
  ];

  programs.vim.defaultEditor = true;

  # Allow running AppImage files directly
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # hardware.pulseaudio.enable = true;
  # users.extraUsers.dmytro.extraGroups = [ "audio" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.vscode-server.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  programs.ssh.startAgent = true;

  programs.fish.enable = true;
  users.users.dmytro.shell = pkgs.fish;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  # FIXME: temporary
  networking.firewall.allowedTCPPorts = [5432 5433];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
