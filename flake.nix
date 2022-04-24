{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    username = "doos";
    mkNixOS = modules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        inherit modules;
      };
  in {
    nixosConfigurations = {
      n2 = mkNixOS [
        ./nixos/n2.nix
      ];
      vm = mkNixOS [
        ./nixos/vm.nix
      ];
    };
    packages.${system}.homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      configuration = import ./home/home.nix;
      inherit system username;
      homeDirectory = "/home/${username}";
      # Update the state version as needed.
      # See the changelog here:
      # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.11
      stateVersion = "21.11";
      # pass through arguments to home.nix:
      extraSpecialArgs = {inherit nur;};
    };
  };
}
