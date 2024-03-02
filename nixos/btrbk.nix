{config, ...}: {
  fileSystems = {
    "/mnt/btr_pool" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = ["subvolid=5"];
    };
  };
  services.btrbk = {
    instances.dkl4-home = {
      onCalendar = "daily"; # `man systemd.timer` calendar spec
      settings = {
        volume."/mnt/btr_pool" = {
          snapshot_dir = "btrbk_snapshots";
          subvolume = "/home";
        };
      };
    };
  };
}
