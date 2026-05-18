# ====/// WEATHERSTAFF \\\ zeditor.nix \\====
# ==//./infra/software/homeProfiles/zeditor.nix \\==
# ==// high-velocity graphical editor \\==

{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      ui_font_size = 14;
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
