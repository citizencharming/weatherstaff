# ====/// WEATHERSTAFF \\\ boot.nix \\====
# ==//./infra/hardware/nixosProfiles/boot.nix \\==
# ==// uefi ignition sequence \\==

{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
      systemd-boot = {
      enable = true;
      configurationLimit = 9;
      consoleMode = "max";
    };

    timeout = 3;
  };
}
