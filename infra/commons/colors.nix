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
      base01 = "14003d"; # Deep Bruise
      base02 = "220066"; # Amethyst Shadow
      base03 = "7a2900"; # Dried Blood
      base04 = "cc7a00"; # Hypoxic Purple
      base05 = "ff9900"; # Amber Phosphor
      base06 = "ff7700"; # Copper Circuits
      base07 = "ffbb00"; # Sodium Flare
      base08 = "ff0055"; # Laser Red
      base09 = "0066ff"; # Caution Orange
      base0A = "ffee00"; # Acid Yellow
      base0B = "00ff55"; # Radioactive Green
      base0C = "00e5ff"; # Cherenkov Cyan
      base0D = "7700ff"; # Electric Blue
      base0E = "ff00aa"; # Psychic Magenta
      base0F = "b3003b"; # Crimson Shadow
      extbg1 = "0f0c1b"; # Coagulated Darkness
      extbg2 = "0a140f"; # Sunken Viridian
    };
  };
in {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = black-rainbow;
}
