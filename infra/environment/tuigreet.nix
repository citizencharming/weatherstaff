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
{pkgs, ...}: let
  c = {
    base00 = "0a001f"; # Abyssal Indigo
    base01 = "14003d"; # Deep Bruise
    base02 = "220066"; # Amethyst Shadow
    base03 = "7a2900"; # Dried Blood
    base04 = "a34700"; # Hypoxic Purple
    base05 = "ff7700"; # Amber Phosphor
    base06 = "ff9900"; # Golden Circuits
    base07 = "ffbb00"; # Sodium Flare
    base08 = "ff0055"; # Laser Red
    base09 = "0066ff"; # Caution Orange
    base0A = "ffee00"; # Acid Yellow
    base0B = "00ff55"; # Radioactive Green
    base0C = "00e5ff"; # Cherenkov Cyan
    base0D = "7700ff"; # Electric Blue
    base0E = "ff00aa"; # Psychic Magenta
    base0F = "b3003b"; # Crimson Peak
  };
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.tuigreet}/bin/tuigreet "
          + "--time "
          + "--remember "
          + "--asterisks "
          + "--window-padding 2 "
          + "--greeting 'Welcome, my son. Welcome to the machine.' "
          + "--theme 'border=#${c.base0F};text=#${c.base05};prompt=#${c.base0C};time=#${c.base0A};action=#${c.base06};button=#${c.base02};container=#${c.base00};input=#${c.base08}' "
          + "--cmd sway ";
      };
      user = "greeter";
    };
  };
}
