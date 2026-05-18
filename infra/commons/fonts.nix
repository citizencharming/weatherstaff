# ====/// WEATHERSTAFF \\\ fonts.nix \\====
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
# ==//./infra/commons/fonts.nix \\==
#

{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-cjk-sans
    fira-code
    iosevka
    victor-mono
    hack-font
    monaspace
  ];

  fonts.fontconfig.enable = true;
}
