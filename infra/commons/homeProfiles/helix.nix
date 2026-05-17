# ====/// WEATHERSTAFF \\\ helix.nix \\====
# ==//./infra/software/homeProfiles/helix.nix \\==
# ==// the modal text surgical tool \\==

{ config, pkgs, ... }:

let
  c = config.colorScheme.palette;
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "dynamic-matrix";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        idle-timeout = 0;
        true-color = true;

        statusline = {
          left = ["mode" "spinner"];
          center = ["file-name"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-type"];
          separator = "■";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };

    themes = {
      dynamic-matrix = {
        "ui.background" = { bg = "#${c.base00}"; };
        "ui.text" = { fg = "#${c.base05}"; };
        "ui.cursor" = { fg = "#${c.base00}"; bg = "#${c.base05}"; };
        "ui.cursor.match" = { fg = "#${c.base0A}"; bg = "#${c.base02}"; };

        # The syntax highlighting matrix
        "keyword" = { fg = "#${c.base0E}"; };        # Magenta
        "function" = { fg = "#${c.base0D}"; };       # Blue
        "string" = { fg = "#${c.base0B}"; };         # Green
        "variable" = { fg = "#${c.base08}"; };       # Red
        "constant.numeric" = { fg = "#${c.base09}"; };# Orange
        "type" = { fg = "#${c.base0A}"; };           # Yellow
        "comment" = { fg = "#${c.base03}"; modifiers = ["italic"]; }; # Ash

        "ui.statusline" = { fg = "#${c.base05}"; bg = "#${c.base01}"; };
        "ui.statusline.normal" = { fg = "#${c.base00}"; bg = "#${c.base0B}"; }; # Green when safe
        "ui.statusline.insert" = { fg = "#${c.base00}"; bg = "#${c.base0A}"; }; # Yellow when writing
      };
    };
  };
}
