# ====/// WEATHERSTAFF \\\ hackerman.nix \\====
# ==//./infra/software/homeProfiles/hackerman.nix \\==

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chisel        # TCP/UDP tunneler
    rathole       # reverse proxy for NAT traversal
    zrok          # peer-tp-peer sharing
    feroxbuster   # content discovery tool
    nuclei        # template-based scanner
    mitmproxy     # TUI web traffic scanner
    rustnet       # TUI traffic analysis
  ];
}
