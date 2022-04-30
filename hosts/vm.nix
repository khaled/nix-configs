{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./base.nix
    ../profiles/zsh.nix
    ../profiles/gnome.nix
    ../profiles/synergy.nix
    ../profiles/firefox.nix
    ../profiles/chromium.nix
    ../profiles/vscode.nix
    ../profiles/apps.nix
  ];
  networking.hostName = "vm";
}
