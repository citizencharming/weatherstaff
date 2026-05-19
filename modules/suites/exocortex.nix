# ====/// WEATHERSTAFF \\\ exocortex.nix \\====
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
# ==//./modules/suites/exocortex.nix \\==
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    obsidian # 📑 Visual Markdown canvas (will inherit Fira Code)
    anytype # 🕸️ Local-first, decentralized cryptographic knowledge grid
    pandoc # ⚗️ Universal document transformer (Markdown to PDF/LaTeX/HTML)
    glow
  ];

  xdg.configFile."obsidian/snippets/nix-colors.css".text = ''
    .theme-dark {
      --background-primary: #${config.colorScheme.palette.base00};
      --background-primary-alt: #${config.colorScheme.palette.base01};
      --background-secondary: #${config.colorScheme.palette.base01};
      --text-normal: #${config.colorScheme.palette.base05};
      --text-muted: #${config.colorScheme.palette.base04};
      --text-accent: #${config.colorScheme.palette.base0A};
      --interactive-accent: #${config.colorScheme.palette.base0D};
    }
  '';
}
