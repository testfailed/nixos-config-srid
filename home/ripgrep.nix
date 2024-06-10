{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };

  home.packages = with pkgs; [ ripgrep ];
}
