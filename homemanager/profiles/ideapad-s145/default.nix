{ inputs
, config
, pkgs
, ...
}: {
  imports = [
    ./packages.nix
    ./nix-config.nix
  ];

  modules = {
    fonts.enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
