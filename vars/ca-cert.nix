{
  clan.core.vars.generators.root-ca = {
    files."ca.key" = {
      secret = true;
      deploy = false; # Keep root key offline
    };
    files."ca.crt".secret = false;
    runtimeInputs = [pkgs.step-cli];
    script = ''
      step certificate create "Misselthwaite Root CA" \
        $out/ca.crt $out/ca.key \
        --profile root-ca \
        --no-password \
        --insecure \
        --not-after 87600h
    '';
  };

  clan.core.vars.generators.intermediate-key = {
    files."intermediate.key" = {
      secret = true;
      deploy = true;
    };
    runtimeInputs = [pkgs.step-cli];
    script = ''
      step crypto keypair \
        $out/intermediate.pub \
        $out/intermediate.key \
        --no-password \
        --insecure
    '';
  };

  clan.core.vars.generators.intermediate-cert = {
    files."intermediate.crt".secret = false;
    dependencies = [
      "root-ca"
      "intermediate-key"
    ];
    runtimeInputs = [pkgs.step-cli];
    script = ''
      step certificate create "Misselthwaite Intermediate CA" \
        $out/intermediate.crt \
        --key $in/intermediate-key/intermediate.key \
        --ca $in/root-ca/ca.crt \
        --ca-key $in/root-ca/ca.key \
        --profile intermediate-ca \
        --not-after 8760h \
        --no-password \
        --insecure
    '';
  };
}
