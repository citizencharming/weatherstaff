# ====/// WEATHERSTAFF \\\ fonts.nix \\====
# ==//./infra/commons/homeProfiles/fonts.nix \\==

{ config, pkgs, lib, ... }:

{
  # -----------------------------------------------------------------
  # 🌟 THE ATOMIC INSTALL
  # In Home Manager, font files are simply dropped into your user-space
  # package matrix using the standard package list.
  # -----------------------------------------------------------------
  home.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-cjk-sans
    fira-code
    iosevka
    victor-mono
    hack-font
    monaspace
  ];

  # -----------------------------------------------------------------
  # 🌟 THE CONFIGURATION ENGINE
  # This activates the actual attribute set Home Manager expects,
  # forcing fontconfig to discover and index your new typography.
  # -----------------------------------------------------------------
  fonts.fontconfig.enable = true;
}
