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

{ inputs, pkgs, cell }:
{
  bee = {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true; # NVIDIA
    };
  };

  imports = [
    cell.hardware.diskoConfigurations.ephemeral-root
    cell.hardware.diskoConfigurations.AHN401
    cell.hardware.nixosProfiles.boot
    cell.hardware.nixosProfiles.zen
    cell.hardware.nixosProfiles.amd
    cell.hardware.nixosProfiles.nvidia
    cell.commons.nixosProfiles.mycelium
    cell.commons.homeProfiles.colors
    cell.commons.homeProfiles.terminal
    cell.commons.homeProfiles.helix
    cell.commons.homeProfiles.fish
    cell.commons.homeProfiles.starship
    cell.commons.homeProfiles.fonts
    cell.commons.homeProfiles.cli
    cell.commons.homeProfiles.hyprland
    cell.software.nixosProfiles.audio
    cell.software.homeProfiles.easyeffects
    cell.software.homeProfiles.ide
    cell.software.homeProfiles.zeditor
    cell.software.homeProfiles.qutebrowser
    # Placeholder for future Colony/Clan wrapper
    # cell.software.nixosProfiles.colony
    # Placeholder for future Canopy (Graphical interface)

  ];

  disko.devices.disk.main.device = "/dev/disk/by-id/ata-M4-CT256M4SSD2_000000001220090A6B7A";
  disko.devices.disk.media.device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2326ED442012";
  disko.devices.disk.vault.device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2325AU454104";

  # ==// Ephemeral Boot \ uses snapshot to reset OS to original state \==
  #boot.initrd.postDeviceCommands = inputs.nixpkgs.lib.mkAfter ''
    # mkdir -p /mnt
    # mount -o subvol=/ /dev/mapper/crypt /mnt
    # btrfs subvolume delete /mnt/root || true
    # btrfs subvolume create /mnt/root
    # umount /mnt
    #  '';

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
  networking.nameservers = [ "10.42.1.13" "8.8.8.8" "1.1.1.1" ]

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
        inputs.nix-colors.homeManagerModules.default
      ];
      colorScheme = inputs.nix-colors.colorSchemes.black-rainbow;
      home.username = "i-magi";
      home.homeDirectory = "/home/i-magi";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
  };
}
