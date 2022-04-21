{
  description = "Home Manager config";
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };
  outputs = {
    home-manager,
    nur,
    ...
  }: let
    system = "x86_64-linux";
    username = "doos";
  in {
    packages.${system}.homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      configuration = import ./home.nix;
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
