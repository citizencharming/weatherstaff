# hyprlock.nix
{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          # No image path declared. Creates a flat solid fill block.
          color = "rgb(40, 40, 40)"; # Gruvbox Dark0 (#282828)
          blur_passes = 0;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.3;
          dots_spacing = 0.4;
          dots_center = true;

          outer_color = "rgb(204, 36, 29)"; # Gruvbox Red (#cc241d)
          inner_color = "rgb(29, 32, 33)"; # Gruvbox Dark0_Hard (#1d2021)
          font_color = "rgb(235, 219, 178)"; # Gruvbox Light0 (#ebdbb2)

          fade_on_empty = false;
          placeholder_text = "<i>[ SIGNAL HALTED: ENTER CREDENTIALS ]</i>";
          hide_input = false;
          position = "0, -80";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Chrono Matrix Readout
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(250, 189, 47)"; # Phosphorus Yellow (#fabd2f)
          font_size = 80;
          font_family = "Monaspace Xenon Bold";
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
        # Host Identity Tag
        {
          monitor = "";
          text = "TERMINAL STATION: inland-empire";
          color = "rgb(184, 187, 38)"; # Gruvbox Green (#b8bb26)
          font_size = 12;
          font_family = "Monaspace Xenon";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
