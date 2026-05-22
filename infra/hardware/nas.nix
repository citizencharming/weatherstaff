# ====/// WEATHERSTAFF \\\ nas.nix \\====
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
# ==//./infra/disko/nas.nix \\==
#
{...}: {
  boot = {
    supportedFilesystems = ["zfs"];
    kernalParams = [
      "zfs.zfs_arc_max=${toString (4 * 1024 * 1024 * 1024)}"
    ];
    zfs = {
      devNodes = "/dev/disk/by-id";
      requestEncryptionCredentials = true;
      extraPools = ["vault"];
    };
  };

  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    autoSnapshot = {
      enable = true;
      frequent = 4;
      hourly = 24;
      daily = 7;
    };
  };

  disko.devices = {
    disk = {
      nvme-core = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Reletech_P400_M.2_Pro_Q2000GB_202102011581";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "host";
              };
            };
          };
        };
      };

      hdd-a = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca25c27e810";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };
      hdd-b = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca0734381d4";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };

      hdd-c = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca07377a9e4";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };
      hdd-d = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca25c27dc70";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };

      hdd-e = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca05d5de3c0";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };
      hdd-f = {
        type = "disk";
        device = "/dev/disk/by-id/scsi-35000cca25d870330";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "pool";
              };
            };
          };
        };
      };
    };
    zpool = {
      host = {
        type = "zpool";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          xattr = "sa";
        };
        datasets = {
          "root" = {
            type = "zfs_dataset";
            mountpoint = "/";
            postCreateHook = "zfs snapshot host/root@blank";
          };
          "nix" = {
            type = "zfs_dataset";
            mountpoint = "/nix";
          };
          "persist" = {
            type = "zfs_dataset";
            mountpoint = "/persist";
          };
          "incus" = {
            type = "zfs_dataset";
            options = {mountpoint = "legacy";};
          };
          "db" = {type = "zfs_dataset";};
          "db/relational" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/databases";
            options = {recordsize = "16k";};
          };
          "mirror" = {type = "zfs_dataset";};
          "mirror/vectors" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/qdrant";
            options = {recordsize = "16k";};
          };
          "mirror/cache" = {
            type = "zfs_dataset";
            mountpoint = "/var/cache/ai";
            options = {recordsize = "128k";};
          };
          "vm" = {type = "zfs_dataset";};
          "vm/providence" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/telemetry";
            options = {recordsize = "16k";};
          };
          "vm/lighthouse" = {
            type = "zfs_volume";
            size = "32G";
            options = {volblocksize = "8k";};
          };
          "vm/dorothy" = {
            type = "zfs_volume";
            size = "64G";
            options = {volblocksize = "16k";};
          };
        };
      };
      pool = {
        type = "zpool";
        options = {ashift = "12";};
        rootFsOptions = {
          compression = "lz4";
          atime = "off";
          xattr = "sa";
        };
        topology = {
          type = "topology";
          vdev = [
            {
              mode = "mirror";
              members = ["hdd-a" "hdd-b"];
            }
            {
              mode = "mirror";
              members = ["hdd-c" "hdd-d"];
            }
            {
              mode = "mirror";
              members = ["hdd-e" "hdd-f"];
            }
          ];
        };
        datasets = {
          "cloud" = {type = "zfs_dataset";};
          "cloud/nextcloud" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/nextcloud";
            options = {recordsize = "128k";};
          };
          "sync" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/syncthing";
            options = {recordsize = "128k";};
          };
          "obj" = {type = "zfs_dataset";};
          "obj/garage" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/garage";
            options = {recordsize = "128k";};
          };
          "mirror" = {type = "zfs_dataset";};
          "mirror/models" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/models";
            options = {recordsize = "1M";};
          };
          "sunshine" = {type = "zfs_dataset";};
          "sunshine/steam" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/steam";
            options = {recordsize = "1M";};
          };
          "meta" = {type = "zfs_dataset";};
          "meta/attic" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/attic";
            options = {recordsize = "128k";};
          };
          "meta/forgejo" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/forgejo";
            options = {recordsize = "128k";};
          };
          "providence" = {type = "zfs_dataset";};
          "providence/loki" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/loki-archive";
            options = {recordsize = "128k";};
          };
          "backup" = {type = "zfs_dataset";};
          "backup/borg" = {
            type = "zfs_dataset";
            mountpoint = "/var/lib/borgbackup";
            options = {recordsize = "1M";};
          };
        };
      };
    };
  };
}
