{pkgs, ...}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "HALT SIGNAL";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "TERMINATE SESSION";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "KILL POWER";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "CYCLE CORE";
        keybind = "r";
      }
    ];
    style = ''
      window {
          font-family: "Monaspace Xenon", monospace;
          font-weight: bold;
          font-size: 14pt;
          color: #ebdbb2;

          background-color: rgba(40, 40, 40, 0.92);

          background-image: linear-gradient(
              rgba(28, 28, 28, 0) 95%,
              rgba(29, 32, 33, 0.4) 95%
          );
          background-size: 100% 6px;
      }

      button {
          background-color: #282828; /* Gruvbox Dark0 */
          color: #fabd2f;            /* Phosphorus Yellow */

          border: 3px double #cc241d;
          border-radius: 0px;        /* Sharp, unyielding geometry */

          margin: 25px;
          padding: 15px;

          box-shadow: 6px 6px 0px #1d2021;
          transition: all 0.15s ease-in-out;
      }

      button:focus, button:hover {
          background-color: #cc241d; /* Flashes terminal error red */
          color: #282828;            /* Inverts text to dark */
          border-color: #ebdbb2;     /* High contrast white-cream frame */
          box-shadow: 2px 2px 0px #1d2021;
          transform: translate(4px, 4px); /* Physical click indentation */
      }
    '';
  };
}
