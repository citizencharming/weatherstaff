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
{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-cjk-sans
    fira-code
    pkgs.nerd-fonts.iosevka
    victor-mono
    hack-font
    pkgs.nerd-fonts.monaspace
  ];

  fonts.fontconfig.enable = true;
}
