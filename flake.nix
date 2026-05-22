{
  description = "Project Weatherstaff: A NixOS sovereign deployment. Powered by Clan and Hive.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    flake-parts.url = "github:hercules-ci/flake-parts";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clan-core = {
      url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      systems = ["x86_64-linux"];

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = [
            inputs.clan-core.packages.${system}.clan-cli
          ];
        };
      };

      flake = let
        clan = inputs.clan-core.lib.clan {
          inherit self;
          specialArgs = {
            inherit inputs;
            self = inputs.self;
          };
          meta.name = "weatherstaff";
          meta.domain = "weatherstaff.internal";

          #inventory.services = {
          #  zerotier = {
          #    inland-empire = {};
          #    evil-ball = {};
          #  };
          #};

          machines = {
            #inland-empire = {
            #  nixpkgs.hostPlatform = "x86_64-linux";
            #  imports = [
            #    inputs.disko.nixosModules.disko
            #    inputs.home-manager.nixosModules.home-manager
            #    inputs.sops-nix.nixosModules.sops
            #    (self + "/nodes/terminals/inland-empire.nix")
            #  ];
            #};
            evil-ball = {
              nixpkgs.hostPlatform = "x86_64-linux";
              imports = [
                inputs.disko.nixosModules.disko
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                (self + "/nodes/terminals/evil-ball.nix")
              ];
            };
            #foundation = {
            #  nixpkgs.hostPlatform = "x86_64-linux";
            #  imports = [
            #    inputs.disko.nixosModules.disko
            #    inputs.home-manager.nixosModules.home-manager
            #    inputs.sops-nix.nixosModules.sops
            #    (self + "/nodes/terminals/foundation.nix")
            #  ];
            #};
          };
        };
      in {
        inherit (clan.config) nixosConfigurations clanInternals clanModules;
        clan = clan.config;
      };
    };
}
