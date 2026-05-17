# ====/// WEATHERSTAFF \\\ commons/homeProfiles/default.nix \\====
# ==// The Index of the Common User Space \\==

{
  colors = import ./colors.nix;
  terminal = import ./terminal.nix;
  helix = import ./helix.nix;
  fish = import ./fish.nix;
  starship = import ./starship.nix;
  fonts = import ./fonts.nix;
  hyprland = import ./hyprland.nix;
  cli = import ./cli.nix;
}
