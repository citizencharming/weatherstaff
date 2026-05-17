{ pkgs, ... }:
{
fonts.packages = with pkgs; [
    fira-code
    iosevka
    victor-mono
    hack-font
    monaspace
  ];
}
