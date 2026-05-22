# ====/// WEATHERSTAFF \\\ mako.nix \\====
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
# ==//./modules/services/mako.nix \\==
{config, ...}: let
  c = config.colorScheme.palette;
in {
  services.mako = {
    enable = true;
    font = "Fira Code Nerd Font 12";
    width = 300;
    height = 100;
    margin = "10";
    padding = "10";
    borderSize = 2;
    borderRadius = 0;
    defaultTimeout = 5000;
    groupBy = "summary";

    backgroundColor = "#${c.base01}";
    textColor = "#${c.base05}";
    borderColor = "#${c.base03}";
    progressColor = "source-over #${c.base04}";

    extraConfig = ''
      [urgency=high]
      border-color=#${c.base09}
      text-color=#${c.base0A}
      default-timeout=0
    '';
  };
}
