# ====/// WEATHERSTAFF \\\ nvidia.nix \\====
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
# ==//./infra/hardware/nixosProfiles/nvidia.nix \\==
# ==// deployed on: inland-empire, magic-mirror \\==
{ pkgs, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "99-virtual-cables" = {
          "context.modules" = [
            {
              name = "libpipewire-module-loopback";
              args = {
                "node.name" = "Virtual_Mic_Sink";
                "node.description" = "Composited Audio Gateway";
                "capture.props" = {
                  "media.class" = "Audio/Sink";
                  "audio.position" = [ "FL" "FR" ];
                };
                "playback.props" = {
                  "media.class" = "Audio/Source";
                  "node.passive" = true;
                };
              };
            }
          ];
        };
        "10-clock-optimization" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [ 48000 96000 ];
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 1024;
          };
        };
        "20-disable-suspension" = {
          "monitor.alsa.properties" = {
            "session.suspend-on-idle" = false;
          };
        };
        "10-bluetooth-policy" = {
          "wire-plumber-profiles" = {
            "main" = {
              "bluetooth.autoswitch-to-headset" = false;
            };
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pulsemixer # Volume Mixer
    pwvucontrol # Volume Controller
    qpwgraph # Visual Patchbay
    noise-suppression-for-voice # ML voice processing
  ];
}
