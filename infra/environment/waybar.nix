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
  #config,
  pkgs,
  ...
}:
#let
#c = config.colorScheme.palette;
#in
{
  programs.waybar = {
    enable = true;
    extraPackages = with pkgs; [font-awesome];
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = ["sway/workspaces" "sway/window"];
        modules-center = ["clock"];
        modules-right = ["custom/nixos-updates" "custom/nixos-generation" "pipewire" "network" "battery" "tray"];

        "river/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };

        "sway/window" = {
          max-length = 50;
          format = "[ (title) ]";
        };

        "clock" = {
          format = "[ {:%H:%M :: &b &d} ]";
        };

        "pipewire" = {
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
      }

      #tags button {
        padding: 0 8px;
        background: transparent;
      }

      #tags button.focused {
        font-weight: bold;
      }

      #tags button.urgent {
      }

      #window {
        padding: 0 12px;
      }

      #custom-nixos-updates,
      #custom-nixos-generation,
      #pipewire,
      #battery,
      #network,
      #tray {
        padding: 0 12px;
      }

      #clock {
        padding: 0 14px;
      }
    '';
  };
}
