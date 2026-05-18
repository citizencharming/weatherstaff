# ====/// WEATHERSTAFF \\\ river.nix \\====
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
# ==//./infra/environment/river.nix \\==
#

{ config, pkgs, ... }:

let
  c = config.colorScheme.palette;
  inherit (lib) types;
  cfg = config.wayland.windowManager.river;
in

{
  programs.river = {
    enable = true;
    extraPackages = with pkgs; [
      fuzzel
      wl-clipboard
      cliphist    # Clipboard
      swww
      ristate
    ];
  };

  wayland.windowManager.river = {
    enable = true;
    settings = {
      background.color = "0x${c.base00}";
      border-color-focused = "0x${c.base0D}";
      border-color-unfocused = "0x${c.base02}";
      border-width = 2;
      map = {
        normal = {
          "Super Return" = "spawn ghostty";
          "Super Space" = "spawn fuzzel";
          "Super N" = "spawn nyxt";
          "Super J" = "focus-view next";
          "Super K" = "focus-view previous";
          "Super Z" = "zoom";
          "Super 1" = "set-focused-tags 1";
          "Super 2" = "set-focused-tags 2";
          "Super 3" = "set-focused-tags 4";
          "Super 4" = "set-focused-tags 8";
          "Super 5" = "set-focused-tags 16";
          "Super+Shift 1" = "set-view-tags 1";
          "Super+Shift 2" = "set-view-tags 2";
          "Super+Shift 3" = "set-view-tags 4";
          "Super+Shift 4" = "set-view-tags 8";
          "Super+Shift 5" = "set-view-tags 16";
          "Super Q" = "close";
          "Super L" = "spawn 'swaylock -f'";
          "Super+Shift E" = "exit";
        };
      };
    };
    extraConfig = ''
      swww-daemon &
      ristate &
      riverctl default-layout rivertile &
      rivertile -view-padding 4 -outer-padding 4 -main-ratio 0.5 &
      riverctl background-color 0x${c.base00}
    '';
  };

  xdg.portal = {
    enable=true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock.effects;
    settings = {
      screenshots = true;
      clock = true;
      effect-blur = "9x5";
      effect-vignette = "0.5:0.5"
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 15;
      ring-color = "${c.base00}dd"; # Abyssal Indigo
      inside-color = "${c.base01}99"; # Plasma Shadow
      text-color = "${c.base05}"; # Amber Phosphor
      line-color = "00000000";
      separator-color = "00000000";
      key-hk-color = "${c.base0C}"; # Cyan stroke when typing
      ring-clear-color = "${c.base0E}"; # Magenta on backspace
      ring-ver-color = "${c.base0B}"; # Green on verification
      ring-wrong-color = "${c.base08}"; # Red on failed authentication
    };
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
          format = "[ (title) ]";
        };

        "clock" = {
          format = "[ {:%H:%M :: &b &d} ]";
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
