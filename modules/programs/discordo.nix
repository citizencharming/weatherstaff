# //./modules/tui/discordo.nix \\=
{
  pkgs,
  config,
  ...
}: let
  c = config.colorScheme.palette;
in {
  home.packages = with pkgs; [
    discordo
  ];

  xdg.configFile."discordo/config.toml".text = ''
    auto_focus = false
    editor = "hx"
    status = "online"


    mouse: true
    messages_limit: 100
    editor: "hx"

    timestamps:
    enable = true
    format = "15:04"

    theme:
    background: "#${c.base00}"
    border: "#${c.base02}"
    text:
      normal: "#${c.base05}"
    title:
      title: "#${c.base0D}"

    cache
      enable: true
      expire_messages: "168h"

    keys
      focus_guilds_tree: "Alt+g"
      focus_messages_text: "Alt+m"
      focus_message_input: "Alt+i"
      toggle_guild_folder: "Enter"
      reply_message: "r"
      delete_message: "d"
  '';
}
