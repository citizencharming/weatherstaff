# ====/// WEATHERSTAFF \\\ ephemeral-root.nix \\====
#
#    _
#   - - /, /,               ,  ,,                        ,          /\   /\
#     )/ )/ )         _    ||  ||                       ||    _    ||   ||
#     )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_, =||=  < \, =||= =||=
#    ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.   ||   /-||  ||   ||
#     )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||  ||  (( ||  ||   ||
#  /-_/-_/  \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-   \\,  \/\\  \\,  \\,
#                              _/
#
# ==//./infra/hardware/diskoConfigurations/ephemeral-root.nix \\==
# ==// deployed on: inland-empire, evil-ball, mage-tower \\==
#
{ inputs, cell }:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # ==// EFI Boot \\==
          boot = {
            size = "1G";
            type = "EF00";
            name = "boot";
            # device = "..."; injected in inland-empire.nix)
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          # ==// Nix Store \\==
          nix_store = {
            size = "100G";
            name = "nix";
            # device = "..."; injected in inland-empire.nix)
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" "commit=300" ];
                };
              };
            };
          };
          # ==//Persistent Crypt \\==
          luks_vault = {
          size = "100%";
          type = "luks";
          name = "crypt";
          # device = "..."; injected in inland-empire.nix)
          extraOpenArgs = [ "--allow-discards" ];
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = [ "compress-zstd" "noatime" "commit=300" ];
              };
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [ "compress-zstd" "noatime" "commit=300" ];
              };
              "/home" = {
                mountpoint = "/home";
                mountOptions = [ "compress-zstd" "noatime" "commit=300" ];
              };
              "/snapshots" = {
                mountpoint = "/.snapshots";
                mountOptions = [ "compress-zstd" "noatime" "commit=300" ];
              };
            };
          };
        };
      };
    };
  };
}
