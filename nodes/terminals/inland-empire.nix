# ====/// WEATHERSTAFF \\\ evil-ball.nix \\====
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
# ==//./nodes/terminals/evil-ball.nix \\==
{
  self,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    (self + "/infra/hardware/root.nix") # disko
    (self + "/infra/hardware/boot.nix") # systemd
    (self + "/infra/hardware/zen.nix") # kernel
    (self + "/infra/hardware/amd.nix") # cpu
    (self + "/infra/hardware/radeon.nix") # GPU
    (self + "/infra/hardware/battery.nix")
    (self + "/infra/hardware/audio.nix")
    (self + "/infra/commons/tailscale.nix") # mesh (IPv4)
    (self + "/infra/commons/mycelium.nix") # mesh (IPv6)
    (self + "/infra/environment/tuigreet.nix") # greetd login
    (self + "/modules/suites/control.nix") # mission control
    (self + "/modules/services/proton.nix") # VPN
  ];

  nixpkgs.config.allowUnfree = true;

  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-M4-CT256M4SSD2_000000001220090A6B7A";
      };
      media = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2326ED442012";
        content = {
          type = "btrfs";
          extraArgs = [
            "-f"
          ];
          subvolumes = {
            "/jellyfin" = {
              mountpoint = "/var/lib/jellyfin";
              mountOptions = ["compress=zstd" "noatime" "commit=300"];
            };
            "/media" = {
              mountpoint = "/mnt/media";
              mountOptions = ["noatime" "nodatacow" "commit=300"];
            };
          };
        };
      };
      lore = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WD_Blue_SA510_2.5_2TB_2325AU454104";
        content = {
          type = "btrfs";
          extraArgs = [
            "-f"
          ];
          subvolumes = {
            "/lore" = {
              mountpoint = "/mnt/lore";
              mountOptions = ["compress=zstd" "noatime" "commit=300"];
            };
            "/backup" = {
              mountpoint = "/mnt/borg";
              mountOptions = ["compress=zstd" "noatime" "commit=300"];
            };
          };
        };
      };
    };
  };

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
    options = ["size=2G" "mode=755"];
  };

  # ==// ZRAM Swap \ creates compressed swapfile directly from RAM \==
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking.hostName = "inland-empire";
  networking.useDHCP = false;
  networking.interfaces.eno2.ipv4.addresses = [
    {
      address = "10.42.1.50";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "10.42.1.1";
  networking.nameservers = ["10.42.1.13" "8.8.8.8" "1.1.1.1"];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";

  programs.hyprland.enable = true;
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  users.users.xix-sun = {
    isNormalUser = true;
    description = "Xavier Doolittle";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "docker"];
    initialPassword = "opensesame";
    shell = pkgs.fish;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};

    users.xix-sun = {...}: {
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
        ../../software/homeProfiles/hyprland.nix
        ../../software/homeProfiles/ide.nix
        ../../software/homeProfiles/mako.nix
        ../../software/homeProfiles/media.nix
        ../../software/homeProfiles/zeditor.nix
        ../../software/homeProfiles/qutebrowser.nix
      ];
      home.username = "xix-sun";
      home.homeDirectory = "/home/xix-sun";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
