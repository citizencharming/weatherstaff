# ====/// WEATHERSTAFF \\\ battery.nix \\====
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
# ==//./infra/hardware/battery.nix \\==
#

{ pkgs, ... }:

{
  services.power-profiles-daemon.enable = false;

  services.udev.extraRules = ''SUBSYSTEM=="power_supply",KERNEL="BAT0",ATTR{charge_control_end_threshold}="80"'';

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_ACT = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
      CPU_BOOST_ON_ACT = 1;
      CPU_BOOST_ON_BAT = 0;
      PCIE_ASPM_ON_ACT = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";
      SOUND_POWER_SAVE_ON_AC = 10;
      SOUND_POWER_SAVE_ON_BAT = 1;
      WIFI_PWR_ON_ACT = "off";
      WIFI_PWR_ON_BAT = "on";
      RUNTIME_PM_ON_ACT = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop    # power monitoring
    acpi        # cli tool for checking battery
  ];
}
