# ====/// WEATHERSTAFF \\\ media.nix \\====
# ==//./infra/software/homeProfiles/media.nix \\==
# ==// sensory playback tools and audio visualization configuration \\==

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv         # High-velocity scriptable video and audio command plane
    imv         # Minimalist Wayland image review canvas
    pulsemixer  # Brutalist ncurses-based volume board
    sox         # The Swiss Army knife of sound processing files
  ];

  # -----------------------------------------------------------------
  # 2. THE AUDITORY EQUALIZER (Cava)
  # -----------------------------------------------------------------
  programs.cava = {
    enable = true;
    settings = {
      # Audio input capture parameters hooking straight into the PipeWire conduit
      input = {
        method = "pipewire";
        source = "auto";
      };

      # Layout alignment
      general = {
        framerate = 60;
        bars = 0; # Auto-fit columns to the width of the terminal pane
      };

      # THE RE-MAPPED COLOR MATRIX
      # Dynamically assigns the bars to morph across your active 16 colors
      color = {
        gradient = 1;
        gradient_count = 4;
        gradient_color_1 = "'#${config.colorScheme.palette.base0D}'"; # Blue base
        gradient_color_2 = "'#${config.colorScheme.palette.base0C}'"; # Teal shift
        gradient_color_3 = "'#${config.colorScheme.palette.base0A}'"; # Gold warn
        gradient_color_4 = "'#${config.colorScheme.palette.base08}'"; # Red peak
      };
    };
  };

  # -----------------------------------------------------------------
  # 3. THE BACKEND DAEMON (MPD - Music Player Daemon)
  # -----------------------------------------------------------------
  services.mpd = {
    enable = true;
    musicDirectory = "/home/citizencharming/media/audio";
    playlistDirectory = "/home/citizencharming/media/audio/.playlists";

    # Internal PipeWire output channel mapping
    extraConfig = ''
      audio_output {
        type        "pipewire"
        name        "PipeWire Audio Output Conduit"
      }
    '';
  };
}
