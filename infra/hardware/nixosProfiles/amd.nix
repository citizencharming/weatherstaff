# ====/// WEATHERSTAFF \\\ amd.nix \\====
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
# ==//./infra/hardware/nixosProfiles/amd.nix \\==
# ==// deployed on: inland-empire \\==
{ config, lib, pkgs, ... }:

{
  hardware.cpu.amd.updateMicrocode = true; # BLEEDING EDGE

  boot.initrd.availableKernelModules = [
    "nvme"   # M.2 SSDs
    "xhci_pci" # USB 3.0
    "ahci"   # SATA drives
    "usb_storage"
    "usbhid" # Keyboard/Mouse during early boot
    "sd_mod"
  ];

  # ==// Hardware Acceleration for microVMs \\==
  boot.kernelModules = [ "kvm-amd" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
}
