# //./modules/tui/catgirl.nix \\=
{pkgs, ...}: {
  home.packages = with pkgs; [
    catgirl
  ];

  # Construct a default network profile (e.g., for Libera Chat)
  # To invoke this specific network, your alias would be `catgirl libera`
  xdg.configFile."catgirl/libera".text = ''
    host = irc.libera.chat
    port = 6697
    nick = i-magi
    user = i-magi
    real = Digital Necromancer
    join = #nixos, #catgirl

    # Catgirl natively absorbs your Ghostty terminal colors,
    # but you can override specific UI elements here.
    color = 73 # Binds the UI to a specific 256-color code
  '';

  # You can duplicate the block above to map out other networks
  # like Rizon or local bouncers.
}
