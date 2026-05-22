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
{
  config,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      palettes.black_rainbow = {
        amber = "#${config.colorScheme.palette.base05}";
        indigo = "#${config.colorScheme.palette.base00}";
        purple = "#${config.colorScheme.palette.base04}";
        crimson = "#${config.colorScheme.palette.base0F}";
        red = "#${config.colorScheme.palette.base08}";
        blue = "#${config.colorScheme.palette.base0D}";
        green = "#${config.colorScheme.palette.base0B}";
        cyan = "#${config.colorScheme.palette.base0C}";
        magenta = "#${config.colorScheme.palette.base0E}";
        yellow = "#${config.colorScheme.palette.base0A}";
        orange = "#${config.colorScheme.palette.base09}";
      };
      format = lib.concatStrings [
        "[█](fg:red)"
        "$os$username"
        "$directory"
        "$git_branch$git_status"
        "$direnv"
        "$nix_shell$terraform$rust$python$lua"
        "$docker_context$container"
        "$shell"
        "$time"
        "\n$status$character"
      ];
      os = {
        disabled = false;
        style = "bg:red fg:indigo bold";
        format = "[ $symbol]($style)";
      };
      username = {
        show_always = true;
        style_user = "bg:red fg:indigo bold";
        style_root = "bg:red fg:#ffffff bold";
        format = "[ $user ]($style)[](fg:red bg:orange)";
      };
      directory = {
        style = "bg:orange fg:indigo bold";
        format = "[ $path ]($style)[](fg:orange bg:yellow)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        style = "bg:yellow fg:indigo bold";
        format = "[ ⎇ $branch ]($style)";
        disabled = false;
      };
      git_status = {
        style = "bg:yellow fg:indigo bold";
        format = "[($all_status$ahead_behind )]($style)[](fg:yellow bg:green)";
        disabled = false;
        conflicted = "≡";
        ahead = "▲";
        behind = "▼";
        diverged = "◨";
        untracked = "?";
        stashed = "⚑";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "x";
      };
      direnv = {
        style = "bg:green fg:indigo bold";
        format = "[ ⬢ env ]($style)[](fg:green bg:blue)";
        disabled = false;
      };
      nix_shell = {
        style = "bg:blue fg:indigo bold";
        format = "[ ⎔ $state ]($style)";
        disabled = false;
      };
      terraform = {
        style = "bg:blue fg:indigo bold";
        format = "[ ⬡ $workspace ]($style)";
      };
      rust = {
        style = "bg:blue fg:indigo bold";
        format = "[ ⋈ $version ]($style)";
      };
      python = {
        style = "bg:blue fg:indigo bold";
        format = "[ ⚯ $virtualenv ]($style)";
      };
      lua = {
        style = "bg:blue fg:indigo bold";
        format = "[ ☾ $version ]($style)";
      };
      custom.forge_bridge = {
        when = "true";
        style = "bg:cyan fg:blue";
        format = "[]($style)";
      };
      docker_context = {
        style = "bg:cyan fg:indigo bold";
        format = "[ ⬟ $context ]($style)";
      };
      container = {
        style = "bg:cyan fg:indigo bold";
        format = "[ ■ $name ]($style)[](fg:cyan bg:magenta)";
        disabled = false;
      };
      shell = {
        disabled = false;
        style = "bg:magenta fg:indigo bold";
        format = "[ $indicator ]($style)[](fg:magenta bg:amber)";
      };
      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "bg:purple fg:indigo bold";
        format = "[ ⧖ $time ]($style)[](fg:amber bg:none)";
      };
      status = {
        disabled = false;
        style = "bg:crimson fg:amber bold";
        format = "[ █ ERR:$int ]($style)[](fg:crimson bg:none) ";
      };
      character = {
        success_symbol = "[▶](bold purple)";
        error_symbol = "[▶](bold crimson)";
      };
    };
  };
}
