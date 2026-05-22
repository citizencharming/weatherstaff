# ====/// WEATHERSTAFF \\\ hyprland.nix \\====
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
# ==//./infra/environment/hyprland.nix \\==
#
{
  config,
  pkgs,
  ...
}: let
  # Stable Gruvbox Dark Topology Assignments
  c_void = "rgba(40, 40, 40, 1.0)"; # #282828 (Dark0 Void)
  c_active = "rgba(250, 189, 47, 1.0)"; # #fabd2f (Phosphorus Yellow Accent)
  c_inactive = "rgba(146, 131, 116, 1.0)"; # #928374 (Industrial Gray Subdued)
  c_alert = "rgba(204, 36, 29, 1.0)"; # #cc241d (Tape Error Blood Red)
in {
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
        "col.shadow" = "rgba(29, 32, 33, 0.85)"; # Shadow falls back to Dark0_Hard
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
        "$mod, L, exec, hyprlock" # Call programmatic lock surface
        "$mod, X, exec, wlogout -b 2" # Call custom digital-video tracking grid
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
      ];

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "waybar"
        "hypridle"
      ];
    };
  };

  home.packages = with pkgs; [
    fuzzel # Application Launcher
    wl-clipboard
    cliphist # Clipboard
    hyprpaper # Wallpaper
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "tray"];

        "hyprland/workspaces" = {
          format = "{name}";
        };

        "hyprland/window" = {
          max-lengtt = 50;
          format = "[ (title) ]";
        };

        "clock" = {
          format = "[ {:%H:%M :: %b %d} ]";
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "VOL MUTE";
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
      font-family: "Fira Code", monospace;
      font-weight: bold;
      font-size: 11px;
      color: #ebdbb2; /* Gruvbox Light0 */
    }

    window#waybar {
      background-color: #282828; /* Gruvbox Dark0 Floor */
      border-bottom: 2px solid #fabd2f; /* Phosphorus Yellow Frame Line */
    }

    #workspaces button {
      padding: 0 8px;
      color: #928374; /* Gruvbox Gray for inactive data slots */
      border-radius: 0px;
    }

    #workspaces button.active {
      color: #fabd2f; /* Active phosphorus burn-in highlight */
      border-bottom: 2px solid #cc241d; /* Underline signal block in alert red */
    }

    #clock, #pulseaudio, #network, #tray {
      padding: 0 10px;
      color: #ebdbb2;
    }
  '';
}
