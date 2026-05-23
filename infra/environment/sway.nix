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
{
  pkgs,
  #config,
  ...
}: let
  # c = config.colorScheme.palette;
  mod = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true; # legacy

    config = {
      terminal = "ghostty";
      menu = "wofi";

      window = {
        border = 2;
        titlebar = false;
      };

      gaps = {
        inner = 4;
        outer = 4;
      };

      #colors = {
      #  focused = {
      #    border = "#${c.base05}";
      #    background = "#${c.base01}";
      #    text = "#${c.base05}";
      #    indicator = "#${c.base05}";
      #    childBorder = "#${c.base05}";
      #  };
      #  unfocused = {
      #    border = "#${c.base02}";
      #    background = "#${c.base02}";
      #    text = "#${c.base05}";
      #    indicator = "#${c.base02}";
      #    childBorder = "#${c.base02}";
      #  };
      #};

      keybindings = {
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

  programs.wofi = {
    enable = true;
    #settings = {
    #  colors = {
    #    background = "${c.extbg2}ff";
    #    text = "${c.base05}ff";
    #    match = "${c.base0B}ff";
    #    selection = "${c.base02}ff";
    #  };
    #};
  };

  home.packages = with pkgs; [
    wl-clipboard
    cliphist
  ];
}
