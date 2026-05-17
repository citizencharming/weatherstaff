# ====/// WEATHERSTAFF \\\ terminal.nix \\====
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
# ==//./infra/software/homeProfiles/terminal.nix \\==
# ==// deployed on: all workstations \\==

{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "Monaspace Neon";
      font-size = 12;
      font-feature = [ "liga" "calt" ];
      cursor-style = "block";
      cursor-blink = true;
      background-opacity = 0.9;
      window-decoration = false;
      window-padding-x = 16;
      window-padding-y = 16;
      window-theme = "ghostty";
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#${config.colorScheme.palette.base01}";
      global-toggle = "f12";

      renderer = "vulkan";
      vsync = true;

      # -----------------------------------------------------------------
            # THE 16-COLOR DYNAMIC MATRIX
            # -----------------------------------------------------------------
            background = "${config.colorScheme.palette.base00}";
            foreground = "${config.colorScheme.palette.base05}";
            cursor-color = "${config.colorScheme.palette.base05}";
            selection-background = "${config.colorScheme.palette.base02}";
            selection-foreground = "${config.colorScheme.palette.base05}";

            palette = [
              "0=#${config.colorScheme.palette.base00}" # Black
              "1=#${config.colorScheme.palette.base08}" # Red
              "2=#${config.colorScheme.palette.base0B}" # Green
              "3=#${config.colorScheme.palette.base0A}" # Yellow
              "4=#${config.colorScheme.palette.base0D}" # Blue
              "5=#${config.colorScheme.palette.base0E}" # Magenta
              "6=#${config.colorScheme.palette.base0C}" # Cyan
              "7=#${config.colorScheme.palette.base05}" # White

              "8=#${config.colorScheme.palette.base03}"
              "9=#${config.colorScheme.palette.base09}"
              "10=#${config.colorScheme.palette.base01}"
              "11=#${config.colorScheme.palette.base02}"
              "12=#${config.colorScheme.palette.base04}"
              "13=#${config.colorScheme.palette.base06}"
              "14=#${config.colorScheme.palette.base0F}"
              "15=#${config.colorScheme.palette.base07}"
            ];

      keybind = [
        "ctrl+shift+x=close_surface"
        "ctrl+shift+d=new_split:right"
        "ctrl+shift+e=new_split:down"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+l=goto_split:right"
        "ctrl+shift+k=goto_split:up"
        "ctrl+shift+j=goto_split:down"
      ];

      xdg.configFile."ghostty/crt-phosphor-bloom.glsl".text = ''
          void mainImage(out vec4 fragColor, in vec2 fragCoord) {
              vec2 uv = fragCoord.xy / iResolution.xy;

              // Center coordinates for the curve
              vec2 crt_uv = uv * 2.0 - 1.0;

              // The Barrel Distortion Algorithm
              vec2 offset = crt_uv.yx / 5.0;
              crt_uv = crt_uv + crt_uv * offset * offset;
              crt_uv = crt_uv * 0.5 + 0.5;

              // If the distortion pushes the coordinate off-screen, render black void
              if (crt_uv.x < 0.0 || crt_uv.x > 1.0 || crt_uv.y < 0.0 || crt_uv.y > 1.0) {
                  fragColor = vec4(0.0, 0.0, 0.0, 1.0);
                  return;
              }

              // Chromatic Aberration (Bleeding the RGB channels slightly apart)
              float r = texture(iChannel0, crt_uv + vec2(0.001, 0.0)).r;
              float g = texture(iChannel0, crt_uv).g;
              float b = texture(iChannel0, crt_uv - vec2(0.001, 0.0)).b;

              // The Scanline Burn
              float scanline = sin(uv.y * 800.0) * 0.04;

              // Synthesize the final pixel
              fragColor = vec4(r - scanline, g - scanline, b - scanline, 1.0);
          }
        '';
    };
  };
}
