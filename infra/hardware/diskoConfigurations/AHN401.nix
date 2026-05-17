# ====/// WEATHERSTAFF \\\ media-vault.nix \\====
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
# ==//./infra/hardware/diskoConfigurations/media-vault.nix \\==
# ==// deployed on: inland-empire \\==
{ inputs, cell }:
{
  disko.devices = {
    disk = {
      media = {
        type = "disk";
        # device = "..."; injected in inland-empire.nix)
        content = {
          type = "btrfs";
          extraArgs = [
            "-f"
          ];
          subvolumes = {
            "/jellyfin" = {
              mountpoint = "/var/lib/jellyfin";
              mountOptions = [ "compress=zstd" "noatime" "commit=300" ];
            };
            "/media" = {
              mountpoint = "/mnt/media";
              mountOptions = [ "noatime" "nodatacow" "commit=300" ];
            };
          };
        };
      };
      vault = {
        type = "disk";
        # device = "..."; injected in inland-empire.nix)
        content = {
          type = "btrfs";
          extraArgs = [
            "-f"
          ];
          subvolumes = {
            "/lore" = {
              mountpoint = "/mnt/vault/lore";
              mountOptions = [ "compress=zstd" "noatime" "commit=300" ];
            };
            "/borg" = {
              mountpoint = "/mnt/vault/borg";
              mountOptions = [ "compress=zstd" "noatime" "commit=300" ];
            };
          }
        };
      };
    };
  };
}
