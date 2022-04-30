{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    # TODO look into nixos-shell.url = "github:Mic92/nixos-shell";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    ...
  } @ attrs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    username = "doos";
    mkHost = hostModule:
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit home-manager username;
        };
        modules = [
          (./hosts + "/${hostModule}.nix")
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [nur.overlay];
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
  in {
    nixosConfigurations = lib.genAttrs ["n2" "vm"] mkHost;
  };
}
