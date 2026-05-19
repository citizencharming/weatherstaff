# ====/// WEATHERSTAFF \\\ colors.nix \\====
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
# ==//./infra/commons/colors.nix \\==
#
{inputs, ...}: let
  # =================================================================
  # ===================== // PRISMATIC VOID \\ ======================
  # =================================================================
  black-rainbow = {
    slug = "black-rainbow";
    name = "Black Rainbow";
    author = "citizen.charming";
    palette = {
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
  };
in {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = black-rainbow;
}
