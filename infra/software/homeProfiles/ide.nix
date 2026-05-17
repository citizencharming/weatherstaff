# ====/// WEATHERSTAFF \\\ ide.nix \\====
# ==//./infra/software/homeProfiles/ide.nix \\==
# ==// local development environments and global language servers \\==

{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    jq                    # JSON processor
    yq-go                 # YAML processor
    just                  # Task runner
    lazygit               # TUI wrapper for Git
    delta                 # Syntax-highlighting pager
    gum                   # TUI menus for scripts
    # Documentation
    vhs                   # CLI recording engine
    asciinema             # terminal session recorder
    asciinema-language    # Compile .cast logs into GIFs
    termtosvg             # Compiles live terminal into termtosvg
    ttyd                  # Sharing terminal over web sockets
    mermaid-cli           # Text to diagram
    # LSPs
    nixd                  # Nix
    marksman              # Markdown
    bash-language-server  # Bash
    taplo                 # TOML (also formatter)
    fish-lsp              # Fish
    just-LSP              # Justfile
    yaml-language-server  # YAML
    # Linters
    statix                # Nix, security risks and anti-patterns
    deadnix               # Nix, unused varialbe bindings, dead code
    vale                  # Analyzes English prose
    shellcheck            # Shell scripts
    yamllint              # YAML
    markdownlint-cli      # Markdown
    # Formatters
    alejandra             # Nix (opinionated)
    shfmt                 # Shell scripts
    biome                 # JavaScript, TypeScript, JSX, TSX, JSON, and JSONC
    prettier              # HTML, CSS, SCSS, Less, GraphQL
  ];

  home.sessionVariables = {
    VHS_NO_SANDBOX = "false";
  }
}
