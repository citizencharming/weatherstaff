# ====/// WEATHERSTAFF \\\ fish.nix \\====
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
# ==//./infra/commons/fish.nix \\==
#
{pkgs, ...}: let
  voidGreen = "#011206";
  voidRed = "#140007";
  nmtuiDark = "root=black,black;window=black,black;border=magenta,black;title=magenta,black;textbox=white,black;button=black,red;actbutton=red,black;listbox=white,black;actlistbox=black,red";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.openssh}/bin/ssh-add -A 2>/dev/null
      set fish_greeting
      set -g fish_color_autosuggestion '555' 'brblack'
      set -g fish_color_cancel -r
      set -g fish_color_command --bold
      set -g fish_color_comment red
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end brmagenta
      set -g fish_color_error brred
      set -g fish_color_escape 'bryellow' '--bold'
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator bryellow
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_redirection brblue
      set -g fish_color_search_match 'bryellow' '--background=brblack'
      set -g fish_color_selection 'white' '--bold' '--background=brblack'
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
      ${pkgs.fastfetch}/bin/fastfetch
      echo ""
      set_color ffbb00
      echo "Unveil, O Thou who givest sustenance to the Universe,"
      echo "from whom all proceed, to whom all must return,"
      echo "unveil to us that face of the True Sun now hidden by a vase of golden light,"
      echo "so that we may see the truth, and do our whole duty on our journey to thy sacred seat."
      set_color normal
      echo ""
    '';

    shellAbbrs = {
      regen = "sudo nixos-rebuild switch --flake .";
      repot = "home-manager switch --flake .";
      update = "nix flake update";
      prune = "nix store optimise";
      compost = "nix-collect-garbage --delete-older-than 7d";
    };

    shellAliases = {
      hx = "ghostty --font-family='Monaspace Xenon' -e hx";
      ls = "eza --icons --git";
      ll = "eza -l --icons --git --header";
      la = "eza -a --icons --git";
      tree = "eza --tree --icons";
      cat = "bat";
      find = "fd";
      purge = "tmpfs_purge";
      sysd = "systemctl";
      yazi = "ghostty --font-family='Monaspace Krypton' -e yazi";
      man = "ghostty --font-family='Monaspace Xenon' --background='${voidGreen}' -e man";
      tldr = "ghostty --font-family='Monaspace Xenon' --background='${voidGreen}' -e tealdeer";
      info = "ghostty --font-family='Monaspace Xenon' --background='${voidGreen}' -e info";
      lazygit = "ghostty --font-family='Monaspace Xenon' --background='${voidRed}' -e lazygit";
      soft = "ghostty --font-family='Monaspace Xenon' --background='${voidRed}' -e soft";
      nmtui = "ghostty --font-family='Monaspace Krypton' -e env NEWT_COLORS='${nmtuiDark}' nmtui";
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
}
