# ====/// WEATHERSTAFF \\\ bash.nix \\====
# ==//./infra/software/homeProfiles/bash.nix \\==
# ==// the immutable posix fallback matrix \\==

{ config, pkgs, ... }:

let
  c = config.colorScheme.palette;
in
{
  programs.bash = {
    enable = true;

    historySize = 50000;
    historyFileSize = 100000;
    historyControl = [ "ignoredups" "ignorespace" ];

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons=always --git --color=always --group-directories-first";
      ll = "${pkgs.eza}/bin/eza -la --icons=always --git --color=always --group-directories-first";
      cat = "${pkgs.bat}/bin/bat --style=plain --paging=never";
      grep = "${pkgs.ripgrep}/bin/rg";
    };

    initExtra = ''
      # If not running interactively, bypass the remaining initialization routines
      [[ $- != *i* ]] && return

      # Enable color support for legacy systems that ignore standard terminfo
      export COLORTERM="truecolor"

      # Fallback Prompt Architecture
      # If Starship fails to ignite, this draws a stark, brutalist mathematical
      # prompt utilizing your exact base16 error and coordinate colors.
      PS1="\[\e[1;31m\]◆\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \[\e[1;32m\]λ\[\e[0m\] "

      # Auto-Correction Wards
      shopt -s cdspell   # Minor typo tolerance when shifting directories
      shopt -s checkwinsize # Re-calculate window geometry after every background return
      shopt -s globstar  # Enable recursive matching (**/*) for script operations
    '';
  };
}
