# ====/// WEATHERSTAFF \\\ cli.nix \\====
#
#
#       _
#      - - /, /,              ,  ,,
#        )/ )/ )        _    ||  ||
#        )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_,
#       ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.
#        )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||
#     /-_/-_/   \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-
#                                      _/
#
#
# ==//./infra/software/homeProfiles/cli.nix \\==
# ==// user-space tactical utilities and terminal sensors \\==

{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--color=bg+:#${config.colorScheme.palette.base01},bg:#${config.colorScheme.palette.base00},spinner:#${config.colorScheme.palette.base0C},hl:#${config.colorScheme.palette.base0D}"
      "--color=fg:#${config.colorScheme.palette.base05},header:#${config.colorScheme.palette.base0D},info:#${config.colorScheme.palette.base0A},pointer:#${config.colorScheme.palette.base0C}"
      "--color=marker:#${config.colorScheme.palette.base0C},fg+:#${config.colorScheme.palette.base05},prompt:#${config.colorScheme.palette.base0A},hl+:#${config.colorScheme.palette.base0A}"
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

  home.packages = with pkgs; [
    ripgrep          # Replaces grep
    tldr             # Simplified Documentation
    sops             # Secrets Management
    rbw              # Bitwarden
    cliphist         # Clipboard tracker
    wayshot          # Screenshot
    snappy           # Cropper and modifier
    which            # Locates absolute binary paths within the Nix store
    man-db           # Local system manual pager
    texinfo          # GNU info documentation reader
    unzip            # Archive extraction
    less             # Traditional text pager
    chafa            # Image to ASCII
    glow             # Markdown renderer
    rsync
    btop
  ];

  programs.rbw.settings = {
    email = "xavier.doolittle@gmail.com"; # Will be obfuscated via Clan vars later
    base_url = null; # Defaults to official Bitwarden servers unless self-hosted
  };
}
