{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  users.users.dmytro.extraGroups = ["docker"];
}
