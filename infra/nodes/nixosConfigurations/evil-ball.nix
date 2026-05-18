# ====/// WEATHERSTAFF \\\ evil-ball.nix \\====
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
# ==//./infra/nodes/nixosProfiles/evil-ball.nix \\==
# ==// deployed on: ALR401 \\==

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../../hardware/diskoConfigurations/ephemeral-root.nix
    ../../hardware/nixosProfiles/boot.nix
    ../../hardware/nixosProfiles/zen.nix
    ../../hardware/nixosProfiles/amd.nix
    ../../hardware/nixosProfiles/radeon.nix
    ../../commons/nixosProfiles/mycelium.nix
    ../../software/nixosProfiles/audio.nix
    ../../software/nixosProfiles/control.nix
    ../../software/nixosProfiles/river.nix
  ];

  nixpkgs.config.allowUnfree = true;

  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-UMIS_RPJTJ256MEE1OWX_SS1B60641Z1CH17K029S";

  # ==// Ephemeral Boot \ uses snapshot to reset OS to original state \==
  #boot.initrd.postDeviceCommands = inputs.nixpkgs.lib.mkAfter ''
  #   mkdir -p /mnt
  #   mount -o subvol=/ /dev/mapper/crypt /mnt
  #   btrfs subvolume delete /mnt/root || true
  #   btrfs subvolume create /mnt/root
  #   umount /mnt
  #    '';

  # ==// Ephemeral Cache \ uses virtual memory over SSD for tmp/cache files \==
#  boot.tmp.useTmpfs = true;
#  boot.tmp.tmpfsSize = "50%";

#  fileSystems."/var/cache" = {
#    device = "none";
#    fsType = "tmpfs";
#    options = [ "size=2G" "mode=755" ];
#  };

  # ==// ZRAM Swap \ creates compressed swapfile directly from RAM \==
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking.networkmanager.enable = true;
  networking.hostName = "evil-ball";
  networking.useDHCP = false;
  networking.interfaces.eno2.ipv4.addresses = [{
    address = "10.42.1.70";
    prefixLength = 24;
  }];
  networking.defaultGateway = "10.42.1.1";
  networking.nameservers = [ "10.42.1.13" "8.8.8.8" "1.1.1.1" ];

  hardware.enableRedistributableFirmware = true;

  #clan.core = {
  #  meta.name = "weatherstaff";
  #  machineName = "inland-empire";
  #  networking.targetHost = "root@10.42.1.12";
  #};

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";

  programs.river.enable = true;
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.i-magi = {
    isNormalUser = true;
    description = "citizen.charming";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    initialPassword = "opensesame";
    shell = pkgs.fish;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.i-magi = { ... }: {
      imports = [
              ../../commons/homeProfiles/cli.nix
              ../../commons/homeProfiles/colors.nix
              ../../commons/homeProfiles/terminal.nix
              ../../commons/homeProfiles/helix.nix
              ../../commons/homeProfiles/fish.nix
              ../../commons/homeProfiles/starship.nix
              ../../commons/homeProfiles/fonts.nix
              ../../software/homeProfiles/easyeffects.nix
              ../../software/homeProfiles/exocortex.nix
              ../../software/homeProfiles/hackerman.nix
              ../../software/homeProfiles/river-user.nix
              ../../software/homeProfiles/nyxt.nix
              ../../software/homeProfiles/mako.nix
              ../../software/homeProfiles/media.nix
              ../../software/homeProfiles/zeditor.nix
              ../../software/homeProfiles/qutebrowser.nix
            ];
      home.username = "i-magi";
      home.homeDirectory = "/home/i-magi";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
