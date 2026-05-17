# ====/// WEATHERSTAFF \\\ easyeffects.nix \\====
#
#
#       _
#      - - /, /,               ,  ,,                        ,          /\   /\
#        )/ )/ )         _    ||  ||                       ||    _    ||   ||
#        )__)__)  _-_   < \, =||= ||/\\  _-_  ,._-_  _-_, =||=  < \, =||= =||=
#       ~)__)__) || \\  /-||  ||  || || || \\  ||   ||_.   ||   /-||  ||   ||
#        )  )  ) ||/   (( ||  ||  || || ||/    ||    ~ ||  ||  (( ||  ||   ||
#     /-_/-_/  \\,/   \/\\  \\, \\ |/ \\,/   \\,  ,-_-   \\,  \/\\  \\,  \\,
#                                      _/
#
#
# ==//./infra/software/homeProfiles/easyeffects.nix \\==
# ==// deployed on: evil-ball, inland-empire \\==

{ config, pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
    preset = "Voice_Processing";
  };

  xdg.configFile."easyeffects/input/Voice_Processing.json".text = builtins.toJSON {
    "input" = {
      "blocklist" = [];
      "plugins_order" = [
        "rnnoise"    # Neural Processing
        "gate"       # Voice Gate
        "compressor" # Smoothing of Spikes
        "equalizer"  # Polish
      ];

      "rnnoise" = {
        "bypass" = false;
        "model-name" = ""; # Defaults to the standard high-performance model
      };

      "gate" = {
        "bypass" = false;
        "threshold" = -40.0; # Decibels. Anything quieter than this is silenced.
        "ratio" = 4.0;
        "attack" = 5.0;      # Milliseconds to open the gate
        "release" = 100.0;   # Milliseconds to close the gate
      };

      "compressor" = {
        "bypass" = false;
        "threshold" = -18.0;
        "ratio" = 3.5;
        "attack" = 20.0;
        "release" = 150.0;
        "makeup" = 3.0;      # Boost the smoothed signal slightly
      };

      "equalizer" = {
        "bypass" = false;
        "mode" = "iap";
        "balance" = 0.0;
        "bands" = [
          { "frequency" = 80;  "q" = 1.0; "gain" = -3.0; "type" = "highpass"; } # Cut sub-bass mud
          { "frequency" = 200; "q" = 1.0; "gain" = 2.0;  "type" = "bell"; }     # Add chest warmth
          { "frequency" = 3000;"q" = 1.0; "gain" = 1.5;  "type" = "bell"; }     # Boost presence
        ];
      };
    };
  };
}
