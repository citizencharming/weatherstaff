# ====/// WEATHERSTAFF \\\ waybar.nix \\====
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
# ==//./infra/environment/waybar.nix \\==
#
{
  config,
  pkgs,
  ...
}: let
  c = config.colorScheme.palette;
in {
  programs.waybar = {
    enable = true;
    extraPackages = with pkgs; [font-awesome];
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = ["river/tags" "river/window"];
        modules-center = ["clock"];
        modules-right = ["custom/nixos-updates" "custom/nixos-generation" "pulseaudio" "network" "battery" "tray"];

        "river/tags" = {
          num-tags = 9;
        };

        "river/window" = {
          max-length = 50;
          format = "[ (title) ]";
        };

        "clock" = {
          format = "[ {:%H:%M :: &b &d} ]";
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "VOL MUTE";
        };

        "battery" = {
          format = "BAT {capacity}%";
          format-charging = "CHG {capacity}%";
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
    style = ''
      * {
        font-family: "Iosevka Nerd Font", monospace;
        font-size: 10px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: #${c.base00}; /* Abyssal Indigo */
        color: #${c.base06}; /* Sodium Flare */
        border-bottom: 2px solid #${c.base02}; /* Ultraviolet Iron */
      }

      #tags button {
        padding: 0 8px;
        color: #${c.base05}; /* Amber Phosphor */
        background: transparent;
        border-right: 1px solid #${c.base01}; /* Plasma Shadow */
      }

      #tags button.focused {
        background-color: #${c.base0E}; /* Psychic Magenta */
        color: #${c.base00};
        font-weight: bold;
      }

      #tags button.urgent {
      background-color: #${c.base08}; /* Laser Red */
      color: #${c.base00};
      }

      #window {
        padding: 0 12px;
        color: #${c.base06};
      }

      #custom-nixos-updates
      #custom-nixos-generation
      #pulseaudio,
      #battery,
      #network,
      #tray {
        padding: 0 12px;
        border-left: 1px solid #${c.base02};
        background-color: #${c.base01};
      }

      #clock {
        padding: 0 14px;
        color: #${c.base0A}; /* Golden Circuitry */
        background-color: #${c.base00};
      }

      #custom-nixos-updates { color: #${c.base05}; }
      #custom-nixos-generation { color: #${c.base0D}; }
    '';
  };
}
