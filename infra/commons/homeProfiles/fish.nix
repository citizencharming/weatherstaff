# ====/// WEATHERSTAFF \\\ fish.nix \\====
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
# ==//./infra/software/homeProfiles/fish.nix \\==
# ==// deployed on: all \\==

{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      ${pkgs.fastfetch}/bin/fastfetch
      echo ""
      set_color color3
      echo "Unveil, O Thou who givest sustenance to the Universe,"
      echo "from whom all proceed, to whom all must return,"
      echo "unveil to us that face of the True Sun now hidden by a vase of golden light,"
      echo "so that we may see the truth, and do our whole duty on our journey to thy sacred seat."
      set_color normal
      echo ""
    '';

    shellAbbrs = {
      hx = "ghostty --font-family='Monaspace Xenon' -e hx";

      # Nix
      regen = "sudo nixos-rebuild switch --flake .";
      repot = "home-manager switch --flake .";
      update = "nix flake update";
      prune = "nix store optimise";
      compost = "nix-collect-garbage --delete-older-than 7d";

      # Files
      ls = "eza --icons --git";
      ll = "eza -l --icons --git --header";
      la = "eza -a --icons --git";
      tree = "eza --tree --icons";
      cat = "bat";
      find = "fd";

      purge = "tmpfs_purge";
      sysd = "systemctl";
    };

    functions = {
      # ==// tmpfs Purge \\==
      tmpfs_purge = {
        body = ''
          echo "Initiating purging of the tmpfs caches..."

          # mortal cache (safe)
          if test -d ~/.cache
              echo "Purging user cache space (~/.cache)..."
              rm -rf ~/.cache/*
          end

          # system cache (sudo)
          if test -d /var/cache
              echo "Purging system cache space (/var/cache)..."
              sudo rm -rf /var/cache/*
          end

          # stale tmp files (excluding active sockets)
          echo "Purging stale entities in /tmp (older than 2 days)..."
          sudo find /tmp -mindepth 1 -maxdepth 1 \
              ! -name 'wayland-*' \
              ! -name 'tmux-*' \
              ! -name 'ssh-*' \
              ! -name '.X11-unix' \
              ! -name '.ICE-unix' \
              -mtime +2 -exec rm -rf {} +

          echo "The substrate is clean. Memory un-claimed by the caches has been liberated."
        '';
      };
    };
  };

  home.packages = with pkgs; [
    eza         # Replacement for ls
    bat         # Replacement for cat
    fzf         # Fuzzy Finder
    zoxide      # Directory Jumper
    fastfetch   # System Architecture
    fd          # Replacement for find
    ripgrep     # Replacement for grep
    yazi        # File manager
  ];
}
