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
      };

    outputs = { self, nixpkgs, flake-parts, ... } @ inputs:
      flake-parts.lib.mkFlake { inherit inputs; }
    {
      systems = [ "x86_64-linux" ];

      flake = {
        #nixosConfigurations.inland-empire = nixpkgs.lib.nixosSystem {
          #system = "x86_64-linux";
          #specialArgs = { inherit inputs; };
          #modules = [
            #inputs.disko.nixosModules.disko
            #inputs.home-manager.nixosModules.home-manager
            #inputs.sops-nix.nixosModules.sops
            #./infra/nodes/nixosConfigurations/inland-empire.nix
            #];
          #};
        nixosConfigurations.evil-ball = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; self = inputs.self; };
          modules = [
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops
            (self + "/nodes/terminals/evil-ball.nix")
          ];
        };
      };
    };
  }
