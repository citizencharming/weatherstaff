# ====/// WEATHERSTAFF \\\ nyxt.nix \\====
# ==//./infra/software/homeProfiles/nyxt.nix \\==

{ inputs, pkgs, ... }:

let
  themes = import ./infra/software/homeProfiles/colors.nix { inherit inputs; };
  br = themes.black-rainbow.palette;
  ghost = themes.digital-necromancy.palette;
in

{
  home.packages = with pkgs; [
    nyxt    # Lisp programmable browser
    xclip   # shim
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
      :background-color "#{br.base00}"
      :text-color "#{br.base05}"
      :primary-color "#{br.base0A}"
      :secondary-color "#{br.base02}"
      :accent-color "#{br.base0C}"
      ))
    (define-configuration browser
      ((theme *theme-black-rainbow*)))
  '';
}
