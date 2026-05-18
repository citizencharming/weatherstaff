{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    font = "Fira Code Nerd Font 10";
    width = 300;
    height = 100;
    margin = "10";
    padding = "10";
    borderSize = 2;
    borderRadius = 0;
    defaultTimeout = 5000;
    groupBy = "summary";
  };
}
