# ====/// WEATHERSTAFF \\\ ghostty.nix \\====
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
# ==//./infra/commons/ghostty.nix \\==
#
{
  #config,
  ...
}:
#let
#  c = config.colorScheme.palette;
#in
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "MonaspiceNE Nerd Font";
      font-size = 12;
      font-feature = ["liga" "calt"];
      cursor-style = "block";
      cursor-style-blink = true;
      background-opacity = 0.9;
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      window-theme = "ghostty";
      #custom-shader = "crt-phosphor-bloom.glsl";
      unfocused-split-opacity = 0.7;
      #unfocused-split-fill = "#${c.base01}";

      #background = "${c.base00}";
      #foreground = "${c.base05}";
      #cursor-color = "${c.base05}";
      #selection-background = "${c.base02}";
      #selection-foreground = "${c.base05}";

      #palette = [
      #  "0=#${c.base00}" # Black
      #  "1=#${c.base08}" # Red
      #  "2=#${c.base0B}" # Green
      #  "3=#${c.base0A}" # Yellow
      #  "4=#${c.base0D}" # Blue
      #  "5=#${c.base0E}" # Magenta
      #  "6=#${c.base0C}" # Cyan
      #  "7=#${c.base05}" # White

      #  "8=#${c.base03}"
      #  "9=#${c.base09}"
      #  "10=#${c.base01}"
      #  "11=#${c.base02}"
      #  "12=#${c.base04}"
      #  "13=#${c.base06}"
      #  "14=#${c.base0F}"
      #  "15=#${c.base07}"
      #];

      keybind = [
        "ctrl+shift+x=close_surface"
        "ctrl+shift+d=new_split:right"
        "ctrl+shift+e=new_split:down"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+l=goto_split:right"
        "ctrl+shift+k=goto_split:up"
        "ctrl+shift+j=goto_split:down"
        "global:f12=toggle_quick_terminal"
      ];
    };
  };

  xdg.configFile."ghostty/crt-phosphor-bloom.glsl".text = ''
      void mainImage(out vec4 fragColor, in vec2 fragCoord) {
        vec2 uv = fragCoord.xy / iResolution.xy;
        vec2 crt_uv = uv * 2.0 - 1.0;

        // CHROMATIC ABERRATION
        float r = texture(iChannel0, crt_uv + vec2(0.001, 0.0)).r;
        float g = texture(iChannel0, crt_uv).g;
        float b = texture(iChannel0, crt_uv - vec2(0.001, 0.0)).b;

    //    // SCANLINE
    //    float scanline = sin(uv.y * 800.0) * 0.04;
    //    fragColor = vec4(r - scanline, g - scanline, b - scanline, 1.0);
    //  }
  '';
}
