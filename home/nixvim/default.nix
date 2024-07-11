{
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim

    ./colors
    ./plugins

    # ./todo.nix
    ./autocommands.nix
    ./completion.nix
    ./keybindings.nix
    ./options.nix
  ];

  programs.nixvim = {
    enable = true; # ==: false

    # nixvim uses IFD; so not using it on Linux (breaks colmena apply)
    # enable = pkgs.stdenv.isDarwin;
  };
}
