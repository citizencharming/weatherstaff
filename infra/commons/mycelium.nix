# ====/// WEATHERSTAFF \\\ mycelium.nix \\====
# ==//./infra/software/nixosProfiles/mycelium.nix \\==
# ==// end-to-end encrypted kademlia dht overlay network \\==

{ pkgs, ... }:

{
  services.mycelium = {
    enable = true;
    openFirewall = true;
    addHostedPublicNodes = true;
  };
}
