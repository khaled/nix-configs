{modulesPath, ...}: {
  imports = [
    ./base.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  networking.hostname = "vm";
}
