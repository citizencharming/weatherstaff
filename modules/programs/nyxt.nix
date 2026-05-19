# ====/// WEATHERSTAFF \\\ nyxt.nix \\====
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
# ==//./modules/programs/nyxt.nix \\==
#
{
  config,
  pkgs,
  ...
}: let
  c = config.colorScheme.palette;
in {
  home.packages = with pkgs; [
    nyxt # Lisp programmable browser
    xclip # shim
  ];

  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
  };

  xdg.configFile."nyxt/config.lisp".text = ''
    ;; auto-hibernate buffers
    (define-configuration web-buffer
      ((nyxt/web-mode:auto-hibernate-p t)))
    ;; enforce VIM mode & dark mode
    (define-configuration buffer
      ((default-modes (append '(nyxt/vi-mode:vi-normal-mode

      nyxt/style-mode:dark-mode) %slot-default%))))
    ;; overwrite theme
    (defparamter "theme-black-rainbow"
      (make-instance 'theme:theme
      :background-color "#{c.base00}"
      :text-color "#{c.base05}"
      :primary-color "#{c.base0A}"
      :secondary-color "#{c.base02}"
      :accent-color "#{c.base0C}"
      ))
    (define-configuration browser
      ((theme *theme-black-rainbow*)))
  '';
}
