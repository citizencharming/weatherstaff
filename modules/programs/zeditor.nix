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
{...}: {
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
      buffer_font_family = "Fira Code";

      buffer_font_features = {
        calt = true;
        liga = true;
      };

      theme = "One Dark";
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
