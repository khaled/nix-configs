{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.home-manager = {
    url = github:nix-community/home-manager;
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nur.url = "github:nix-community/NUR";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    ...
  } @ attrs: {
    nixosConfigurations.n2 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = attrs // {inherit system;};
      modules = [
        {nixpkgs.overlays = [nur.overlay];}
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
