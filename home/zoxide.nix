{ ... }:
{
  programs.zoxide = {
    enable = true; # *: false

    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

    options = [
      "--cmd j"
      "--hook pwd"
    ];
  };
}
