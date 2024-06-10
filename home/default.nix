{ self, inputs, ... }:
# { self, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
        imports = [
          ./xdg.nix

          inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-index-database.hmModules.nix-index
          # ./_1password.nix
          # ./tmux.nix
          ./neovim.nix
          # # ./helix.nix
          ./ssh.nix
          # ./starship.nix
          # ./terminal.nix
          ./nix.nix
          ./git.nix
          ./direnv.nix
          # ./zellij.nix
          # # ./nushell.nix
          # ./just.nix
          # # ./powershell.nix
          # ./juspay.nix
          ./ripgrep.nix

          # ./fzf.nix
          ./gnutools.nix
          ./bat.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          ./bash.nix
          ./vscode-server.nix
        ];
      };
      common-darwin = {
        imports = [
          self.homeModules.common
          ./zsh.nix
          # # ./bash.nix
          # # ./kitty.nix
          # ./himalaya.nix
        ];
      };
    };
  };
}
