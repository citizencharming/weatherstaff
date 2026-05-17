# ====/// WEATHERSTAFF \\\ paperless.nix \\====
# ==//./infra/software/nixosProfiles/paperless.nix \\==
# ==// persistent system data and document processing daemons \\==

{ config, pkgs, ... }:

{
  # -----------------------------------------------------------------
  # 1. THE DECENTRALIZED SYNCHRONIZATION ENGINE (Syncthing)
  # -----------------------------------------------------------------
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

  # -----------------------------------------------------------------
  # 2. THE CHRONICLE ENGINE (Paperless-ngx)
  # -----------------------------------------------------------------
  services.paperless = {
    enable = true;

    # Network address binding. Restricted to localhost loops.
    # Access is brokered securely via your local browser plane.
    address = "127.0.0.1";
    port = 28981;

    # Administrative credentials initialization
    passwordFile = "/var/src/secrets/paperless-password"; # Secured sops/password location

    # Raw ingestion configurations for the OCR engines
    settings = {
      PAPERLESS_OCR_LANGUAGE = "eng";
      PAPERLESS_TIME_ZONE = "America/Chicago";
      PAPERLESS_OCR_USER_ARGS = builtins.toJSON {
        "optimize" = 1;
        "pdfa_image_compression" = "lossless";
      };
    };
  };

  # Ensure the system environment incorporates the auxiliary dependencies
  environment.systemPackages = with pkgs; [
    poppler-utils # PDF toolkit utilities for manual document parsing
  ];
}
