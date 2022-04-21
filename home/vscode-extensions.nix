{pkgs, ...}:
(with pkgs.vscode-extensions; [
  matklad.rust-analyzer
])
++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "vscode-deno";
    publisher = "denoland";
    version = "3.12.0";
    sha256 = "sha256-ZsHCWQtEQKkdZ3uk072ZBfHFRzk4Owf4h7+szHLgIeo=";
  }
  {
    name = "alejandra";
    publisher = "kamadorueda";
    version = "1.0.0";
    sha256 = "sha256-COlEjKhm8tK5XfOjrpVUDQ7x3JaOLiYoZ4MdwTL8ktk=";
  }
  {
    name = "nix-ide";
    publisher = "jnoortheen";
    version = "0.1.20";
    sha256 = "sha256-Q6X41I68m0jaCXaQGEFOoAbSUrr/wFhfCH5KrduOtZo=";
  }
  {
    name = "errorlens";
    publisher = "usernamehw";
    version = "3.4.2";
    sha256 = "sha256-fdmKpLpIh7e9eDSLkPdNJiaOx+vRiY4PWHb+w3wE38U=";
  }
]
