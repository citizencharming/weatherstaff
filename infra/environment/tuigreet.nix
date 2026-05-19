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
in

{
  services.greetd = {
    enable = true;
    settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet " +
                "--time " +
                "--remember " +
                "--asterisks " +
                "--window-padding 2" +
                "--greeting 'Welcome, my son. Welcome to the machine.' " +
                "--theme 'border=#${c.base0F};text=#${c.base05};prompt=#${c.base0C};time=#${c.base0A};action=#${c.base06};button=#${c.base0E};container=#${c.base00};input=#${c.base08}' " +
                "--cmd river";
      };
    user = "greeter";
    };
  };
}
