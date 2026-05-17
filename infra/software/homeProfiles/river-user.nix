# ====/// WEATHERSTAFF \\\ river-user.nix \\====
#
#
#       _
#      - - /, /,               ,  ,,                        ,          /\   /\
#        )/ )/ )         _    ||  ||                       ||    _    ||   ||
#        )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_, =||=  < \, =||= =||=
#       ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.   ||   /-||  ||   ||
#        )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||  ||  (( ||  ||   ||
#     /-_/-_/  \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-   \\,  \/\\  \\,  \\,
#                                      _/
#
#
# ==//./infra/software/homeProfiles/river-user.nix \\==

{ config, pkgs, ... }:

let
c = config.colorScheme.palette;
in

{
  xdg.configFile."river/init" {
    executable = true;
    text = ''
      #!/bin/sh
      riverctl map normal Mod4 Return spawn terminal
      riverctl map normal Mod4 D spawn fuzzel
      riverctl map normal Mod4 Q close
      riverctl map normal Mod4+Shift E exit
      riverctl map normal Mod4 K focus-view next
      riverctl map normal Mod4 J focus-view previous
      riverctl map normal Mod4 Space zoom
      riverctl default-layout rivertile
      rivertile -view-padding 4 -outer-padding 4 -main-ratio 0.60 &
      riverctl background-color 0x${c.base00}
      riverctl border-color-unfocused 0x${c.base02}
      riverctl border-color-focused 0x${c.base0A}
      riverctl border-color-urgent 0x${c.base08}
      riverctl border-width 2
    ''
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "river/tags" "river/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/nixos-updates" "custom/nixos-generation" "pulseaudio" "network" "tray" ];

        "river/tags" = {
          num-tags = 9;
        };

        "river/window" = {
          max-length = 50;
          format = "[ (title) ]"
        };

        "clock" = {
          format = "[ {:%H:%M :: &b &d} ]";
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted - "VOL MUTE";
        };

        "network" = {
          format-wifi = "WIFI {essid}";
          format-ethernet = "ETH {ipaddr}";
          format-disconnected = "OFFLINE";
        };

        "custom/nixos-generation" = {
          exec = "stat -c &Y /run/current-system | awk '{print int((systime() - $1) / 86400) \"d\"}'";
          interval = 3600;
          format = "SYS {}";
        };

        "custom.nixos-updates" = {
          exec = "nixos-rebuild dry-build 2>&1 | grep -c 'These derivations will be built'";
          interval = 21600;
          format = "UPD {}";
        };
      };
    };
#    style = ''
#      * {
#      font-family: "Iosevka Nerd Font", monospace;
#      font-size: 10px;
#      border: none;
#      border-radius: 0;
#      }
#
#      window#waybar {
#      background-color:
#      }
#    ''
  };
}
