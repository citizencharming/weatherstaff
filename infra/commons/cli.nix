# ====/// WEATHERSTAFF \\\ cli.nix \\====
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
# ==//./infra/commons/cli.nix \\==
#

{ config, pkgs, ... }:

let
  c = config.colorScheme.palette;
in

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--color=bg+:#${c.base01},bg:#${ce.base00},spinner:#${c.base0C},hl:#${c.base0D}"
      "--color=fg:#${c.base05},header:#${c.base0D},info:#${c.base0A},pointer:#${c.base0C}"
      "--color=marker:#${c.base0C},fg+:#${c.base05},prompt:#${c.base0A},hl+:#${c.base0A}"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
      style = "numbers,changes,header";
    };
  };

  programs.eza = {
    enable = true;
    icons = "always";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration= true;
    settings = {
      manager = {
        ratio = [ 1 4 3 ];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_dir_furst = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
        image_filter = "lanczos3";
      };
    };
    theme = {
      manager = {
        cmd = { fg = "#${c.base0C}"; }; # Cyan
        hovered = {
          fg = "#${c.base00}"; # Indigo
          bg = "#${c.base0E}"; # Magenta
          bold = true;
        };
        file_transparent = false;
        dir_transparent = false;
      };
      status = {
        separator_open = "";
        separator_close = "";
        mode_normal = {
          fg = "#${c.base00}";
          bg = "#${c.base0B}"; # Green
          bold = true;
        };
        mode_select = {
          fg = "#${c.base00}";
          bg = "#${c.base09}"; # Blue
          bold = true;
        };
        mode_unset = {
          fg = "#${c.base00}";
          bg = "#${c.base08}"; # Red
          bold = true;
        };
      };
      keymap = {
        manager.prepend_keymap = [
          { on = [ "Esc" ]; run = "leave"; desc = "Go back to parent"; }
          { on = [ "e" ]; ru = "open --interactive"; desc = "Open in editor"; }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    ripgrep          # Replaces grep
    tldr             # Simplified Documentation
    sops             # Secrets Management
    rbw              # Bitwarden
    wayshot          # Screenshot
    snappy           # Cropper and modifier
    which            # Locates absolute binary paths within the Nix store
    man-db           # Local system manual pager
    texinfo          # GNU info documentation reader
    less             # Traditional text pager
    chafa            # Image to ASCII
    rsync
    btop
    git
    zoxide
    fd
    curl
  ];

  programs.rbw.settings = {
    email = "xavier.doolittle@gmail.com"; # Will be obfuscated via Clan vars later
    base_url = null; # Defaults to official Bitwarden servers unless self-hosted
  };
}
