{ ... }:
{
  programs.fzf = {
    enable = true; # *: false

    tmux = {
      enableShellIntegration = true; # *: false
      shellIntegrationOptions = [ "-d 40%" ]; # *: [ ]
    };
  };
}
