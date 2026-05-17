# ====/// WEATHERSTAFF \\\ c&c.nix \\====
# ==//./infra/software/homeProfiles/c&c.nix \\==
{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    trippy        # ping + tracerout
    gping         # graphical ping
    rustnet       # socket monitoring
    nmap          # network cartgography
    termshark     # TUI packet dissection
    homelabinfo
    netdata
    homepage
    colmena
    nixos-anywhere
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
      title = "Weatherstaff Command & Control"
      favicon = "https://raw.githubusercontent.com/walkxcode/dashkboard-icons/main/png/nixos.png";
    };
    services = [

    ];
  };

  networking.firewall.allowedTCPPorts = [ 8082 19999 ];
}
