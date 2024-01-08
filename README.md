# dkl4 configuration

NixOS configuration for my personal laptop.

### 

Test system deployed to a Proxmox VM.


#### Bootstrapping

Follow the guide at https://github.com/nix-community/disko/blob/master/docs/quickstart.md

TODO: use nixos-anywhere for installation

#### Updating

After making the changes to the flake, apply the changes by running:

```
nixos-rebuild switch --flake .#dkl4 --target-host root@dkl4.home.kyrych.uk
```

or, if running this on the laptop directly instead of remotely:

```
nixos-rebuild switch --flake .#dkl4
```
