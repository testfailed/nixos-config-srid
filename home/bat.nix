{ pkgs, ... }:
{
  # REF: <https://home-manager-options.extranix.com/?query=bat&release=master>
  # REF: <https://github.com/sharkdp/bat>
  programs.bat = {

    enable = true;

    config = {
      # tabs = "2";
      # wrap = "never";
      # color = "always";
      # paging = "never";
      # paging = "always";
      # pager = "less -FR --mouse";
      # theme = "Monokai Extended";
      # theme = "TwoDark"; # NOTE: not properly working in batman.
      # style = "plain";

      map-syntax = [
        "*.conf:INI"
        "*.ino:C++"
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
        ".ignore:Git Ignore"
      ];
    };

    # REF: <https://github.com/eth-p/bat-extras>
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];

  };
}
