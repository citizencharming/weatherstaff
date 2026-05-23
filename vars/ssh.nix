{
  clan.core.vars.generators.ssh-ca = {
    share = true;
    files."ca" = {
      secret = true;
      deploy = false;
    };
    files."ca.pub" = {secret = false;};
    runtimeInputs = [pkgs.openssh];
    script = ''
      ssh-keygen -t ed25519 -N "" -f $out/ca
      mv $out/ca.pub $out/ca.pub
    '';
  };

  # Host-specific SSH keys
  clan.core.vars.generators.ssh-host = {
    files."ssh_host_ed25519_key" = {
      secret = true;
      owner = "root";
      group = "root";
      mode = "0600";
    };
    files."ssh_host_ed25519_key.pub" = {secret = false;};
    files."ssh_host_ed25519_key-cert.pub" = {secret = false;};
    dependencies = ["ssh-ca"];
    runtimeInputs = [pkgs.openssh];
    script = ''
      ssh-keygen -t ed25519 -N "" -f $out/ssh_host_ed25519_key

      ssh-keygen -s $in/ssh-ca/ca \
        -I "host:${config.networking.hostName}" \
        -h \
        -V -5m:+365d \
        $out/ssh_host_ed25519_key.pub
    '';
  };

  services.openssh = {
    hostKeys = [
      {
        path = config.clan.core.vars.generators.ssh-host.files."ssh_host_ed25519_key".path;
        type = "ed25519";
      }
    ];
  };
}
