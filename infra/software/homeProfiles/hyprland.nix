# ====/// WEATHERSTAFF \\\ hyprland.nix \\====
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
# ==//./infra/software/homeProfiles/hyprland.nix \\==

{ config, pkgs, ... }:

let
  c_void   = "rgba(${config.colorScheme.palette.base00}ff)";
  c_active = "rgba(${config.colorScheme.palette.base0A}ff)";
  c_inactive = "rgba(${config.colorScheme.palette.base03}ff)";
  c_alert  = "rgba(${config.colorScheme.palette.base08}ff)";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true; # legacy applications
    configType = "lua";

    settings = {
      monitor = ",preferred,auto,1"; # overriden in host specific settings
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;

        "col.active_border" = c_active;
        "col.inactive_border" = c_inactive;

        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        drop_shadow = true;
        shadow_range = 15;
        shadow_render_power = 3;
        "col.shadow" = "rgba(000000aa)";
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;
        # Define a sharp, mechanical bezier curve
        bezier = "mechanical, 0.05, 0.9, 0.1, 1.0";

        animation = [
          "windows, 1, 3, mechanical, slide"
          "windowsOut, 1, 3, mechanical, slide"
          "border, 1, 2, default"
          "fade, 1, 2, default"
          "workspaces, 1, 4, mechanical, slide"
        ];
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ghostty" # terminal emulator
        "$mod, D, exec, fuzzel" # app launcher
        "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy" # cliphist
        # custom toggles
        "$mod SHIFT, R, exec, toggle-redshift"
        "$mod SHIFT, T, exec, toggle-theme"
        # Windows
        "$mod, Q, killactive,"
        "$mod SHIFT, E, exit," # Violent exit to TTY
        "$mod, F, togglefloating,"
        "$mod SHIFT, F, fullscreen,"
        # Layout
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        # Focus
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
      ];

      # Mouse Bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "waybar"
      ];

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };

  home.packages = with pkgs; [
    fuzzel      # Application Launcher
    wl-clipboard
    cliphist    # Clipboard
    hyprpaper   # Wallpaper
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
        };

        "hyprland/window" = {
          max-lengtt = 50;
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
  };

    style = ''
      * {
        font-family: "JetBrains Mono", monospace;
        font-size: 12px;
        color: #${config.colorScheme.palette.base05};
      }
      window#waybar {
        background-color: #${config.colorScheme.palette.base00};
        border-bottom: 2px solid #${config.colorScheme.palette.base0A};
      }
      #workspaces button {
        padding: 0 5px;
        color: #${config.colorScheme.palette.base05};
      }
      #workspaces button.active {
        color: #${config.colorScheme.palette.base0A};
        font-weight: bold;
      }
    '';
  };
}
