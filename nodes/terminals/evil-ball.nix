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

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./infra/hardware/root.nix # disko
    ./infra/hardware/boot.nix # systemd
    ./infra/hardware/zen.nix # kernel
    ./infra/hardware/amd.nix # cpu
    ./infra/hardware/radeon.nix # GPU
    ./infra/hardware/battery.nix
    ./infra/hardware/audio.nix
    ./infra/commons/tailscale.nix # mesh (IPv4)
    ./infra/commons/mycelium.nix # (IPv6)
    ./infra/environment/tuigreet.nix # greetd login
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
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

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        color = {
          "1" = "blue"; # Hyper Violet
          "2" = "cyan"; # Cherenkov Cyan
        };
        padding = {
          top = 1;
          right = 2;
        };
      display = {
        separator = ">>"
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
          format = ">>> [ BONE ] ==============================="
          formatColor = "green"
        }
        { type = "host"; key = "    SYS"; keyColor = "green"; }
        { type = "cpu"; key = "    CPU"; temp = true; keyColor = "green"; }
        { type = "gpu"; key = "    GPU"; temp = true; keyColor = "green"; }
        { type = "memory"; key = "    RAM"; keyColor = "green"; }
        { type = "swap"; key = "    SWP"; keyColor = "green"; }
        { type = "disk"; key = "    DSK"; keyColor = "green"; }
        "break"
        {
          type = "custom";
          format = ">>> [ BLOOD ] =============================="
          formatColor = "red"
        }
        { type = "os"; key = "    O/S"; keyColor = "red"; }
        { type = "kernel"; key = "    KRN"; keyColor = "red"; }
        { type = "packages"; key = "    PKG"; keyColor = "red"; }
        { type = "wm"; key = "    W/M"; keyColor = "red"; }
        { type = "display"; key = "   RES"; keyColor = "red"; }
        { type = "terminal"; key = "   TRM"; keyColor = "red"; }
        {
          type = "command";
          key = "   GEN";
          keyColor = "red"
          text = "basename$(readlink /nix/var/nix/profiles/system) | cut -d'-' -f2";
        }
        "break"
        {
          type = "custom";
          format = ">>> [ BREATH ] ============================="
          formatColor = "cyan"
        }
        { type = "battery"; key = "   PWR"; keyColor = "cyan"; }
        { type = "publicip"; key = "    NET"; timeout = 800; keyColor = "cyan"; }
        { type = "localip"; key = "   LAN"; showMAC = true; keyColor = "cyan"; }
        {
          type = "command";
          key = "   MYC";
          keyColor = "cyan";
          text = ''ip=$(ip -6 addr show dev mycelium0 2>/dev/null | awk '/inet6/ {print $2}' | head -n1); [ -z "$ip" ] && echo "Unlinked" || echo "$ip"'';
        }
        {
          type = "command";
          key = "   TSL";
          keyColor = "cyan";
          text = ''ip=$(ip -4 addr show dev tailscale0 2>/dev/null | awk '/inet/ {print $2}' | head -n1); [ -z "$ip" ] && echo "Unlinked" || echo "$ip"'';
        }
        {
          type = "command";
          key = "   VPN";
          keyColor = "cyan";
          text = ''ip=$(ip -4 addr show dev proton 2>/dev/null | awk '/inet/ {print $2}' | head -n1); if [ -z "$ip" ]; then && echo "Unlinked"; else echo "$ip [$(curl -sm 2 ipinfo.io/country 2>/dev/null || echo "UNK")]"; fi'';
        }
        { type = "uptime"; key = "    UPT"; }
        {
          type = "command";
          key = "   AGE";
          keyColor = "cyan"
          text = "basename$(readlink /nix/var/nix/profiles/system) | cut -d'-' -f2";
        }
        { type = "shell"; key = "   SHL"; keyColor = "cyan"; }
        { type = "datetime"; key = "    CLK"; keyColor = "cyan"; }
        { type = "locale"; key = "    LOC"; keyColor = "cyan"; }
        "break"
        {
          type = "separator";
          string = "="
          outputColor = "yellow"
        }
        "colors"
        "break"
      ];
    };
  };

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
        ./infra/commons/colors.nix
        ./infra/commons/fonts.nix
        ./infra/commons/fish.nix
        ./infra/commons/ghostty.nix
        ./infra/commons/starship.nix
        ./infra/commons/helix.nix
        ./infra/commons/cli.nix
        ./infra/environment/river.nix
        ./modules/services/mako.nix
        ./modules/services/proton.nix
        ./modules/suites/control.nix
        ./modules/suites/excalibur.nix
        ./modules/suites/exocortex.nix
        ./modules/suites/hackerman.nix
        ./modules/programs/easyeffects.nix
        ./modules/programs/nyxt.nix
        ./modules/programs/qutebrowser.nix
        ./modules/programs/zeditor.nix
      ];
      home.username = "i-magi";
      home.homeDirectory = "/home/i-magi";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
