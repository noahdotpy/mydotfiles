{
  nixConfig.extra-substituters = [ "https://numtide.cachix.org" ];
  nixConfig.extra-trusted-public-keys = [ "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE=" ];

  description = "My homemanager configuration currently deployed on my custom uBlue image at https://github.com/noahdotpy/.myublue";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    homemanager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:guibou/nixGL";

    devshell.url = "github:numtide/devshell";

    parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, ... }:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { config
        , inputs'
        , pkgs
        , system
        , ...
        }:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          _module.args.pkgs = pkgs;

          imports = [ ./devshell.nix ];
          formatter = pkgs.alejandra;
        };
      flake = {
        homeConfigurations."noah@ideapad-s145" = inputs.homemanager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            overlays = [ inputs.nixgl.overlay ];
          };
          modules = [
            {
              _module.args = {
                inherit inputs;
                inherit self;
              };
            }
            ./homemanager/profiles/ideapad-s145
            ./homemanager
          ];
        };
      };
    };
}
