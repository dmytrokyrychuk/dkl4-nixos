{...}: {
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane.enable = true;
  users.users.dmytro.extraGroups = ["scanner" "lp"];
}
