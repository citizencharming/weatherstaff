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
in

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      effect-blur = "9x5";
      effect-vignette = "0.5:0.5";
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
