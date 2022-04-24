{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = {
    self,
    nixpkgs,
    ...
  } @ attrs: {
    nixosConfigurations = {
      n2 = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = attrs // {inherit system;};
        modules = [
          ./n2.nix
        ];
      };
      vm = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = attrs // {inherit system;};
        modules = [
          ./vm.nix
        ];
      };
    };
  };
}
