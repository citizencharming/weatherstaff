# ====/// WEATHERSTAFF \\\ zeditory.nix \\====
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
# ==//./modules/programs/zeditor.nix \\==
#
{config, ...}: let
  c = config.colorScheme.palette;
in {
  xdg.configFile."zed/themes/black-rainbow.json".text = ''
    "name": "Black Rainbow",
    "author": "citizen charming",
    "themes": [
      {
        "name": "Black Rainbow",
        "appearance": "dark",
        "style": {
          "border": "#${c.base01}",
          "background": "#${c.base00}",
          "panel-background": "#${c.base01}",
          "editor.background": "#${c.extbg1}",
          "editor.foreground": "#${c.base05}",
          "editor.gutter.background": "#${c.extbg1}",
          "editor.line_number": "#${c.base0F}",
          "editor.active_line.background": "#${c.base02}",
          "editor.active_line_number": "#${c.base05}",
          "search.match_background": "#${c.extbg2}",
          "status_bar.background": "#${c.base02}",
          "title_bar.background": "#${c.base02}",
          "syntax": {
            "keyword": { "color: "#${c.base0E}" },
            "function": { "color: "#${c.base0D}" },
            "string": { "color: "#${c.base0B}" },
            "number": { "color: "#${c.base09}" },
            "comment": { "color: "#${c.base03}" },
            "constant": { "color: "#${c.base0A}" },
            "variable": { "color: "#${c.base08}" },
            "type": { "color: "#${c.base0C}" }
          }
        }
      }
    ]
  '';

  programs.zed-editor = {
    enable = true;
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      ui_font_size = 16;
      ui_font_family = "Iosevka"; # High density for the file tree and UI

      buffer_font_size = 14;
      buffer_font_family = "Fira Code Mono";

      buffer_font_features = {
        calt = true;
        liga = true;
      };

      theme = "Black Rainbow";
      tabs = {
        file_icons = true;
        git_status = true;
      };

      format_on_save = "on";
      formatter = {
        external = {
          command = "alejandra";
        };
      };
    };
  };
}
