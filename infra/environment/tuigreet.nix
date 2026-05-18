# ====/// WEATHERSTAFF \\\ tuigreet.nix \\====
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
# ==//./infra/environment/tuigreet.nix \\==
#

{ config, pkgs, ... }:

let
  c = config.colorScheme.palette;
in

{
  services.greetd - {
    enable = true;
    settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet " +
                "--time " +
                "--remember " +
                "--greeting 'Welcome, my son. Welcome to the machine.' " +
                "--theme 'border=#${c.base0E};text=#${c.base05};prompt=#${c.base0C};time=#${c.base0E};action=#${c.base0A};button=#${c.base0E};container=#${c.base00};input=#${c.base08}' " +
                "--cmd river";
      };
    user = "greeter";
    };
  };
}
