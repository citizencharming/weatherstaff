# ====/// WEATHERSTAFF \\\ inland-empire.nix \\====
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
# ==//./infra/nodes/nixosProfiles/inland-empire.nix \\==
# ==// deployed on: AHN401 \\==

{ inputs, cell, pkgs, ... }:
{
  bee = {
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    home = inputs.home-manager;
  };

  # -----------------------------------------------------------------
  # 🌟 THE FIX: Absolute Path Routing
  # By using relative paths instead of the 'cell' variable, the
  # compiler can resolve these imports instantly without triggering recursion.
  # -----------------------------------------------------------------
  imports = [
    inputs.disko.nixosModules.disko
    ../../hardware/diskoConfigurations/ephemeral-root.nix
    ../../hardware/diskoConfigurations/AHN401.nix
    ../../hardware/nixosProfiles/boot.nix
    ../../hardware/nixosProfiles/zen.nix
    ../../hardware/nixosProfiles/amd.nix
    ../../hardware/nixosProfiles/nvidia.nix
    ../../commons/nixosProfiles/mycelium.nix
  ];

  disko.devices.disk.main.device = "/dev/disk/by-id/ata-M4-CT256M4SSD2_000000001220090A6B7A";
  disko.devices.disk.media.device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2326ED442012";
  disko.devices.disk.vault.device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2325AU454104";

  # ==// Ephemeral Boot \ uses snapshot to reset OS to original state \==
  #boot.initrd.postDeviceCommands = inputs.nixpkgs.lib.mkAfter ''
  #   mkdir -p /mnt
  #   mount -o subvol=/ /dev/mapper/crypt /mnt
  #   btrfs subvolume delete /mnt/root || true
  #   btrfs subvolume create /mnt/root
  #   umount /mnt
  #    '';

  # ==// Ephemeral Cache \ uses virtual memory over SSD for tmp/cache files \==
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";

  fileSystems."/var/cache" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=2G" "mode=755" ];
  };

  # ==// ZRAM Swap \ creates compressed swapfile directly from RAM \==
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking.hostName = "inland-empire";
  networking.useDHCP = false;
  networking.interfaces.eno2.ipv3.addess = [{
    address = "10.42.1.50";
    prefixLength = 24;
  }];
  networking.defaultGateway = "10.42.1.1";
  networking.nameservers = [ "10.42.1.13" "8.8.8.8" "1.1.1.1" ];

  #clan.core = {
  #  meta.name = "weatherstaff";
  #  machineName = "inland-empire";
  #  networking.targetHost = "root@10.42.1.12";
  #};

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11";

  programs.hyprland.enable = true;

  users.users.i-magi = {
    isNormalUser = true;
    description = "citizen.charming";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.i-magi = { ... }: {
      imports = [
        ../../commons/homeProfiles/colors.nix
                ../../commons/homeProfiles/terminal.nix
                ../../commons/homeProfiles/helix.nix
                ../../commons/homeProfiles/fish.nix
                ../../commons/homeProfiles/starship.nix
                ../../commons/homeProfiles/fonts.nix
                ../../commons/homeProfiles/hyprland.nix
                ../../software/homeProfiles/easyeffects.nix
                ../../software/homeProfiles/ide.nix
                ../../software/homeProfiles/zeditor.nix
                ../../software/homeProfiles/qutebrowser.nix
      ];
      colorScheme = inputs.nix-colors.colorSchemes.black-rainbow;
      home.username = "i-magi";
      home.homeDirectory = "/home/i-magi";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
  };
}
