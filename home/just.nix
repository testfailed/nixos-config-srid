{ pkgs, ... }:
{
  programs.bash = {
    # https://just.systems/man/en/chapter_65.html
    # FIXME: doesn't work (macos)
    initExtra = ''
      # complete -F _just -o bashdefault -o default mk
    '';
  };

  home.shellAliases.mk = "just";
  home.packages = with pkgs; [ just ];
}
