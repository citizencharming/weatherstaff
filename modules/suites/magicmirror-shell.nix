{pkgs ? import <nixpkgs> {config.allowUnfree = true;}}:
pkgs.mkShell {
  name = "cuda-necromancy-forge";

  buildInputs = with pkgs; [
    aichat

    # The NVIDIA-centric compilation environment
    cudaPackages.cudatoolkit
    cudaPackages.cudnn

    (python311.withPackages (ps:
      with ps; [
        pip
        virtualenv
        # This environment now targets native CUDA pipelines:
        # - unsloth (Native CUDA installation)
        # - flash-attn (Compiles natively against the exposed cudatoolkit)
        # - dspy-ai
        # - outlines
        # - nemoguardrails
      ]))

    nodejs_20
  ];

  shellHook = ''
    echo "=================================================="
    echo " 🪞 The Alchemical Forge is awake."
    echo " 🟢 CUDA 12 Environment Strictly Enforced."
    echo "=================================================="

    export CUDA_HOME=${pkgs.cudaPackages.cudatoolkit}
    export LD_LIBRARY_PATH=${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib:$LD_LIBRARY_PATH
    export CUDA_VISIBLE_DEVICES=0

    # Initialize a local Node environment for promptfoo
    export PATH="$PWD/node_modules/.bin:$PATH"
    if [ ! -d "node_modules/promptfoo" ]; then
      npm install promptfoo
    fi
  '';
}
