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
}: let
in {
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
    (self + "/infra/environment/sway.nix")
    (self + "/modules/suites/control.nix") # mission control
    (self + "/modules/services/proton.nix") # VPN
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
        inherit pkgs;
      };
    };
  };

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
  networking.interfaces.eno2.ipv4.addresses = [
    {
      address = "10.42.1.70";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "10.42.1.1";
  networking.nameservers = ["10.42.1.13" "8.8.8.8" "1.1.1.1"];

  hardware.enableRedistributableFirmware = true;

  #clan.core = {
  #  meta.name = "weatherstaff";
  #  machineName = "inland-empire";
  #  networking.targetHost = "root@10.42.1.12";
  #};

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";

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

    users.i-magi = {...}: {
      imports = [
        (self + "/infra/commons/colors.nix")
        (self + "/infra/commons/fonts.nix")
        (self + "/infra/commons/fish.nix")
        (self + "/infra/commons/ghostty.nix")
        (self + "/infra/commons/starship.nix")
        (self + "/infra/commons/helix.nix")
        (self + "/infra/commons/cli.nix")
        (self + "/modules/services/mako.nix")
        (self + "/modules/suites/excalibur.nix")
        (self + "/modules/suites/exocortex.nix")
        (self + "/modules/suites/hackerman.nix")
        (self + "/modules/programs/easyeffects.nix")
        (self + "/modules/programs/nyxt.nix")
        (self + "/modules/programs/qutebrowser.nix")
        (self + "/modules/programs/zeditor.nix")
      ];
      home.username = "i-magi";
      home.homeDirectory = "/home/i-magi";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;

      # TODO: TINKER WITH RIVER BUILDING OWN WINDOW MANAGER
      #wayland.windowManager.river = {
      #  enable = true;
      #  settings = {
      #    background.color = "0x${c.base00}";
      #    border-color-focused = "0x${c.base0D}";
      #    border-color-unfocused = "0x${c.base02}";
      #    border-width = 2;
      #    map = {
      #      normal = {
      #        "Super Return" = "spawn ghostty";
      #        "Super Space" = "spawn fuzzel";
      #        "Super N" = "spawn nyxt";
      #        "Super J" = "focus-view next";
      #        "Super K" = "focus-view previous";
      #        "Super Z" = "zoom";
      #        "Super 1" = "set-focused-tags 1";
      #        "Super 2" = "set-focused-tags 2";
      #        "Super 3" = "set-focused-tags 4";
      #        "Super 4" = "set-focused-tags 8";
      #        "Super 5" = "set-focused-tags 16";
      #        "Super+Shift 1" = "set-view-tags 1";
      #        "Super+Shift 2" = "set-view-tags 2";
      #        "Super+Shift 3" = "set-view-tags 4";
      #        "Super+Shift 4" = "set-view-tags 8";
      #        "Super+Shift 5" = "set-view-tags 16";
      #        "Super Q" = "close";
      #        "Super L" = "spawn 'swaylock -f'";
      #        "Super+Shift E" = "exit";
      #      };
      #    };
      #  };
      #  extraConfig = ''
      #    swww-daemon &
      #    ristate &
      #    riverctl default-layout rivertile &
      #    rivertile -view-padding 4 -outer-padding 4 -main-ratio 0.5 &
      #    rivertctl spawn "waybar"
      #      '';
      #};

      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos_small";
            color = {
              "1" = "blue"; # Hyper Violet
              "2" = "cyan"; # Cherenkov Cyan
            };
            padding = {
              paddingTop = 1;
              paddingLeft = 2;
              paddingRight = 2;
            };
          };
          display = {
            separator = " >> ";
            color = {
              keys = "yellow"; # Gold Circuitry
            };
          };
          modules = [
            "break"
            {
              type = "title";
              color = {
                user = "cyan";
                at = "red";
                host = "green";
              };
            }
            "break"
            {
              type = "custom";
              format = ">>> [ BONE ] ===============================";
              outputColor = "green";
            }
            {
              type = "host";
              key = "       SYS";
              keyColor = "green";
              outputColor = "yellow";
            }
            {
              type = "cpu";
              key = "       CPU";
              temp = true;
              keyColor = "green";
              outputColor = "yellow";
            }
            {
              type = "gpu";
              key = "       GPU";
              temp = true;
              keyColor = "green";
              outputColor = "yellow";
            }
            {
              type = "memory";
              key = "       RAM";
              keyColor = "green";
              outputColor = "yellow";
            }
            {
              type = "swap";
              key = "       SWP";
              keyColor = "green";
              outputColor = "yellow";
            }
            {
              type = "disk";
              key = "       DSK";
              keyColor = "green";
              outputColor = "yellow";
            }
            "break"
            {
              type = "custom";
              format = ">>> [ BLOOD ] ==============================";
              outputColor = "red";
            }
            {
              type = "os";
              key = "       O/S";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "kernel";
              key = "       KRN";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "packages";
              key = "       PKG";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "wm";
              key = "       W/M";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "display";
              key = "       VIZ";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "terminal";
              key = "       TRM";
              keyColor = "red";
              outputColor = "yellow";
            }
            {
              type = "command";
              key = "       GEN";
              keyColor = "red";
              outputColor = "yellow";
              text = "basename$(readlink /nix/var/nix/profiles/system) | cut -d'-' -f2";
            }
            {
              type = "command";
              key = "       AGE";
              keyColor = "red";
              outputColor = "yellow";
              text = "sh -c 's=$(( $(date +%s) - $(stat -c %Y /run/current-system) )); echo \"$((s/86400))d $(((s/3600)%24))h $(((s/60)%60))m\"'";
            }
            "break"
            {
              type = "custom";
              format = ">>> [ BREATH ] =============================";
              outputColor = "cyan";
            }
            {
              type = "battery";
              key = "       PWR";
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "publicip";
              key = "       NET";
              timeout = 800;
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "localip";
              key = "       LAN";
              showMAC = true;
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "command";
              key = "       MYC";
              keyColor = "cyan";
              outputColor = "yellow";
              text = ''ip=$(ip -6 addr show dev mycelium0 2>/dev/null | awk '/inet6/ {print $2}' | head -n1); [ -z "$ip" ] && echo "Unlinked" || echo "$ip"'';
            }
            {
              type = "command";
              key = "       TSL";
              keyColor = "cyan";
              outputColor = "yellow";
              text = ''ip=$(ip -4 addr show dev tailscale0 2>/dev/null | awk '/inet/ {print $2}' | head -n1); [ -z "$ip" ] && echo "Unlinked" || echo "$ip"'';
            }
            {
              type = "command";
              key = "       VPN";
              keyColor = "cyan";
              outputColor = "yellow";
              text = ''ip=$(ip -4 addr show dev proton 2>/dev/null | awk '/inet/ {print $2}' | head -n1); if [ -z "$ip" ]; then && echo "Unlinked"; else echo "$ip [$(curl -sm 2 ipinfo.io/country 2>/dev/null || echo "UNK")]"; fi'';
            }
            {
              type = "shell";
              key = "       SHL";
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "uptime";
              key = "       UPT";
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "datetime";
              key = "       CLK";
              keyColor = "cyan";
              outputColor = "yellow";
            }
            {
              type = "locale";
              key = "       LOC";
              keyColor = "cyan";
              outputColor = "yellow";
            }
            "break"
            {
              type = "separator";
              string = "==";
              outputColor = "yellow";
            }
            "colors"
            "break"
          ];
        };
      };
    };
  };
}
