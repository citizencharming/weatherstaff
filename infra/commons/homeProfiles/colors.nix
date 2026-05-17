# ====/// WEATHERSTAFF \\\ colors.nix \\====
#
#
#       _
#      - - /, /,               ,  ,,                        ,          /\   /\
#        )/ )/ )         _    ||  ||                       ||    _    ||   ||
#        )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_, =||=  < \, =||= =||=
#       ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.   ||   /-||  ||   ||
#        )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||  ||  (( ||  ||   ||
#     /-_/-_/  \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-   \\,  \/\\  \\,  \\,
#                                      _/
#
#
# ==//./infra/software/homeProfiles/colors.nix \\==

{ inputs, config, ... }:

let
  # -----------------------------------------------------------------
  # THE PRISMATIC VOID
  # -----------------------------------------------------------------
  black-rainbow = {
    slug = "black-rainbow";
    name = "Black Rainbow";
    author = "citizen.charming";
    colors = {
      base00 = "0d0e15"; base01 = "151722"; base02 = "1a1c29"; base03 = "32354f";
      base04 = "5f628b"; base05 = "ffb83d"; base06 = "c5c5d6"; base07 = "d1d1d1";
      base08 = "ff4a5a"; base09 = "ff8c00"; base0A = "ffd180"; base0B = "00d08a";
      base0C = "00dfff"; base0D = "827dc8"; base0E = "ff4da6"; base0F = "9b2226";
    };
  };

  # -----------------------------------------------------------------
  # THE 8-BIT HAUNTING
  # -----------------------------------------------------------------
  digital-necromancer = {
    slug = "digital-necromancer";
    name = "Digital Necromancer";
    author = "citizen.charming";
    colors = {
      base00 = "121212"; base01 = "1c1c1c"; base02 = "262626"; base03 = "4e4e4e";
      base04 = "949494"; base05 = "e8e8e8"; base06 = "f5f5f5"; base07 = "d1d1d1";
      base08 = "ff2a40"; base09 = "ffb340"; base0A = "d4b04c"; base0B = "00d95a";
      base0C = "00e5ff"; base0D = "3377ff"; base0E = "d933ff"; base0F = "8b0000";
    };
  };

in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = black-rainbow;
}
