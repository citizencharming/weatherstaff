{
  description = "Project Weatherstaff: A NixOS sovereign deployment. Powered by Clan and Hive.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hive = {
      url = "github:divnix/hive";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.std.follows = "std";
    };
    #clan-core = {
    #  url = "git+https://git.clan.lol/clan/clan-core";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    std,
    hive,
    #clan-core,
    ... } @ inputs:
  #let
    std.growOn {
      inherit inputs;
      cellsFrom = ./infra;
      cellBlocks = with std.blockTypes; with hive.blockTypes; [
        (functions "nixosProfiles")
        (functions "homeProfiles")
        (functions "diskoConfigurations")
        nixosConfigurations
      ];
    }
    {
      nixosConfigurations = hive.collect self "nixosConfigurations";
    };
  #in
  #hiveGraph // {
  #  clanInternals = {
  #    meta = {
  #      name = "weatherstaff";
  #      };
  #    machines."x86_64-linux"."inland-empire" =
  #      hiveGraph.nixosConfigurations.inland-empire.config.clan.core.clanInternals;
  #  };
  #};
}
