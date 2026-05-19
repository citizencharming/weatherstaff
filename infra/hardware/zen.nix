# ====/// WEATHERSTAFF \\\ zen.nix \\====
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
# ==//./infra/hardware/zen.nix \\==
#
{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # less aggressive swap, prioritize retention
    "vm.max_map_count" = 2147483642; # increase memory map areas a process can claim
    "net.core.rmem_max" = 16777216; # ensure local mesh does not drop packets
    "net.core.wmem_max" = 16777216;
  };

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];
}
