# ====/// WEATHERSTAFF \\\ starship.nix \\====
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
# ==//./infra/commons/starship.nix \\==
#
{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''
        $directory$git_branch$git_status$nix_shell$direnv$container
        $character'';
      # Ridge
      # Locality
      directory = {
        style = "bg:color4 fg:color0 bold";
        format = "[ $path ]($style)[](fg:color4 bg:color8)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      # Git
      git_branch = {
        style = "bg:color8 fg:color15 bold";
        format = "[  $branch ]($style)";
        disabled = false;
      };
      git_status = {
        style = "bg:color8 fg:color11 bold";
        format = "[($all_status$ahead_behind )]($style)[](fg:color8 bg:color11)";
        disabled = false;
        # Clean geometric representation of file metadata
        conflicted = "=";
        ahead = "▲";
        behind = "▼";
        diverged = "◀▶";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "x";
      };
      # Nix
      nix_shell = {
        style = "bg:color11 fg:color0 bold";
        format = "[ ▲ $state ]($style)[](fg:color11 bg:color6)";
        disabled = false;
      };
      # direnv
      direnv = {
        style = "bg:color6 fg:color0 bold";
        format = "[ ⬢ env ]($style)[](fg:color6 bg:color5)";
        disabled = false;
      };
      # Container
      container = {
        style = "bg:color5 fg:color15 bold";
        format = "[ ■ $name ]($style)[](fg:color5 bg:none)";
        disabled = false;
      };
      # Prompt
      character = {
        success_symbol = "[◆](bold color2) ";
        error_symbol = "[▼](bold color1) ";
      };
    };
  };
}
