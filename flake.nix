{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    disko,
    nur,
    vscode-server,
    nix-index-database,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.dkl4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs outputs;};
      modules = [
        disko.nixosModules.disko
        nur.modules.nixos.default
        vscode-server.nixosModules.default
        ./nixos/configuration.nix
        ./overlays/postman.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.dmytro.imports = [
            nur.modules.homeManager.default
            ./home-manager/home.nix
          ];
        }
      ];
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.pkgs.alejandra;
  };
}
