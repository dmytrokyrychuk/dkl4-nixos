{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.home-manager.url = "github:nix-community/home-manager/release-23.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nur.url = "github:nix-community/NUR";

  outputs = { self, nixpkgs, home-manager, disko, nur, ... }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations.dkl4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          nur.nixosModules.nur
          ./nixos/configuration.nix
        ];
      };
      homeConfigurations = {
        "dmytro@dkl4" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            nur.hmModules.nur
            ./home-manager/home.nix
          ];
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.pkgs.alejandra;
    };
}
