# ====/// WEATHERSTAFF \\\ sway.nix \\====
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
# ==//./infra/environment/sway.nix \\==
#
{pkgs, ...}: let
  c = {
    base00 = "0a001f"; # Abyssal Indigo
    base01 = "14003d"; # Plasma Shadow
    base02 = "220066"; # Ultraviolet Iron
    base03 = "7a2900"; # Smoking Copper
    base04 = "a34700"; # Terminal Burnout
    base05 = "ff7700"; # Amber Phosphor
    base06 = "ff9900"; # Sodium Flare
    base07 = "ffbb00"; # Solar Yellow
    base08 = "ff0055"; # Laser Red
    base09 = "0066ff"; # Electric Blue
    base0A = "ffee00"; # Gold Circuitry
    base0B = "00ff55"; # Radioactive Green
    base0C = "00e5ff"; # Cherenkov Cyan
    base0D = "7700ff"; # Hyper Violet
    base0E = "ff00aa"; # Psychic Magenta
    base0F = "b3003b"; # Neon Blood
  };
  modifier = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    xwayland.enable = true; # legacy applications

    config = {
      inherit modifier;
      terminal = "ghostty";
      menu = "fuzzel";
      editor = "helix";

      window = {
        border = 2;
        titlebar = false;
      };

      gaps = {
        inner = 4;
        outer = 4;
      };

      colors = {
        focused = {
          border = "#${c.base0D}";
          background = "#${c.base0D}";
          text = "#${c.base05}";
          indicator = "#${c.base0D}";
          childBorder = "#${c.base0D}";
        };
        unfocused = {
          border = "#${c.base02}";
          background = "#${c.base02}";
          text = "#${c.base05}";
          indicator = "#${c.base02}";
          childBorder = "#${c.base02}";
        };
      };

      keybindings = let
        mod = modifier;
      in {
        "${mod}+Return" = "exec ghostty";
        "${mod}+Space" = "exec fuzzel";
        "${mod}+n" = "exec nyxt";
        "${mod}+f" = "exec yazi";
        "Print" = "exec wayshot --stdout | swappy -f -"; # Full screen
        "${mod}+Print" = "exec wayshot -s '$(slurp -f '%x %y %w %h')' --stdout | swappy -f -"; # Select Area
        "${mod}+Shift+Print" = "exec wayshot -w --stdout | swappy -f -"; # Window
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+z" = "fullscreen toggle";
        "${mod}+q" = "kill";
        "${mod}+l" = "exec swaylock -f";
        "${mod}+Shift+e" = "fullscreen toggle";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
      };

      startup = [
        {command = "swww-daemon";}
        {command = "waybar";}
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    fuzzel # Application Launcher
    wl-clipboard
    cliphist
    swww
    waybar
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr];
    config.common.default = "gtk";
  };
}
