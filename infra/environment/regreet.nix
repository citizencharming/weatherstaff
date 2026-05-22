{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-B";
    };
    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
    };
    font = {
      package = pkgs.monaspace;
      name = "Monaspace Xenon 11";
    };
    settings = {
      background = {
        color = "#282828";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };

  fonts.packages = with pkgs; [
    monaspace
  ];

  services.displayManager.sessionPackages = [pkgs.hyprland];
}
