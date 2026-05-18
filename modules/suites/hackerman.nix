# ====/// WEATHERSTAFF \\\ hackerman.nix \\====
#
#
#     _
#    - - /, /,               ,  ,,                        ,          /\   /\
#      )/ )/ )         _    ||  ||                       ||    _    ||   ||
#      )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_, =||=  < \, =||= =||=
#     ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.   ||   /-||  ||   ||
#      )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||  ||  (( ||  ||   ||
#     /-_/-_/  \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-   \\,  \/\\  \\,  \\,
#                                 _/
#
# ==//./modules/suites/hackerman.nix \\==

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
