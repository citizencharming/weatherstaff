# ====/// WEATHERSTAFF \\\ radeon.nix \\====
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
# ==//./infra/hardware/nixosProfiles/radeon.nix \\==
# ==// deployed on: evil-ball \\==
{ pkgs, config, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      lbvdpau-va-gl
      vaapiVdpau
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu = {
    initrd.enable = true;
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };
}
