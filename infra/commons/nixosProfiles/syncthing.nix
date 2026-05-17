# ====/// WEATHERSTAFF \\\ paperless.nix \\====
# ==//./infra/software/nixosProfiles/paperless.nix \\==
# ==// persistent system data and document processing daemons \\==

{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "citizencharming";
    group = "users";

    # State management directory. Stores the database caches
    # and cryptographic node keys.
    dataDir = "/home/citizencharming/.local/share/syncthing";
    configDir = "/home/citizencharming/.config/syncthing";

    # Open the standard synchronization and local discovery ports
    # in the system firewall automatically.
    openDefaultPorts = true;
  };
