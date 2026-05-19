# ====/// WEATHERSTAFF \\\ control.nix \\====
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
# ==//./modules/suites/control.nix \\==
#
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    trippy # ping + tracerout
    gping # graphical ping
    rustnet # socket monitoring
    nmap # network cartgography
    termshark # TUI packet dissection
    netdata
    colmena
    nixos-anywhere
    soft-serve
  ];

  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "ram";
        "history" = "3600";
      };
    };
  };

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;
    settings = {
      title = "Weatherstaff Command & Control";
      favicon = "https://raw.githubusercontent.com/walkxcode/dashkboard-icons/main/png/nixos.png";
    };
    services = [
    ];
  };

  networking.firewall.allowedTCPPorts = [8082 19999];
}
