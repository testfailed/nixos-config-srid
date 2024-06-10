{ pkgs, ... }:
{
  programs.bat = {
    enable = true;

    # REF: <https://github.com/eth-p/bat-extras>
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];

    config = {
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
      pager = "less -FR";
      theme = "TwoDark";
    };
  };
}
