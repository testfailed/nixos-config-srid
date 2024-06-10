{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    ripgrep-all
  ];

  programs.ripgrep = {
    enable = true;

    arguments = [
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };
}
