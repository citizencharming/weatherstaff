# ====/// WEATHERSTAFF \\\ browser.nix \\====
# ==//./infra/software/homeProfiles/browser.nix \\==
# ==// keyboard-driven gpu-accelerated web engine \\==
{
  #config,
  ...
}:
#let
#  c = config.colorScheme.palette;
#in
{
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;

    settings = {
      fonts.default_family = "Iosevka";
      fonts.default_size = "11pt";

      tabs.position = "left";
      tabs.width = 180;
      tabs.show = "always";
      downloads.position = "bottom";

      content.blocking.enabled = true; # Native ad-blocking layer
      content.blocking.method = "both"; # Use both Hosts and AdblockPlus rulesets
      content.canvas_reading.enabled = false; # Block fingerprinting tracking

      #colors = {
      #  # Interface
      #  completion.bg = "#${c.base00}";
      #  completion.fg = "#${c.base05}";
      #  completion.item.selected.bg = "#${c.base0A}";
      #  completion.item.selected.fg = "#${c.base00}";
      #  completion.match.fg = "#${c.base0E}";

      # Tab Column
      #  tabs.bar.bg = "#${c.base00}";
      #  tabs.selected.even.bg = "#${c.base0A}";
      #  tabs.selected.even.fg = "#${c.base00}";
      #  tabs.selected.odd.bg = "#${c.base0A}";
      #  tabs.selected.odd.fg = "#${c.base00}";
      #  tabs.unselected.even.bg = "#usr/${c.base01}";
      #  tabs.unselected.even.fg = "#${c.base04}";
      #  tabs.unselected.odd.bg = "#${c.base01}";
      #  tabs.unselected.odd.fg = "#${c.base04}";

      # Command Prompt Line
      #  statusbar.normal.bg = "#${c.base00}";
      #  statusbar.normal.fg = "#${c.base05}";
      #  statusbar.insert.bg = "#${c.base0B}";
      #  statusbar.insert.fg = "#${c.base00}";
      #  statusbar.command.bg = "#${c.base01}";
      #  statusbar.command.fg = "#${c.base05}";
      #};
    };

    searchEngines = {
      DEFAULT = "https://html.duckduckgo.com/html/?q={}";
      nix = "https://search.nixos.org/packages?channel=unstable&query={}";
      hm = "https://home-manager-options.extranix.com/?query={}";
    };
  };
}
